import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_easy/app/common/util/exports.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Utils {
  const Utils._();

  static Future<void> getLaunchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  static Future<void> saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  static Future<bool> getLoginState() async {
    SharedPreferences? prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      // Xử lý lỗi khi không thể truy cập SharedPreferences
      print('Error accessing SharedPreferences: $e');
    }
    return prefs?.getBool('isLoggedIn') ?? false;
  }

  static String? timestampToDateTime(Timestamp? timestamp) {
    if (timestamp == null) {
      return null; // Trả về null nếu timestamp là null
    }

    // Chuyển đổi timestamp sang DateTime
    DateTime dateTime = timestamp.toDate();

    // Sử dụng DateFormat để định dạng lại DateTime thành chuỗi "dd/mm/yyyy hh:mm"
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

    return formattedDateTime;
  }

  static Future<String> uploadFileToFirebaseStorage(
      String path, String filePath, String name) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(path)
          .child(name);
      await ref.putFile(File(filePath));
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
      return "";
    }
  }

  static String generateCandidateCode() {
    // Độ dài của mã ứng viên
    const int codeLength = 12;

    // Các chữ số từ 0 đến 9
    const String digits = '0123456789';

    // Tạo một đối tượng Random
    final random = Random();

    // Tạo mã ứng viên ngẫu nhiên bằng cách chọn ngẫu nhiên các chữ số từ chuỗi 'digits'
    String code = '';
    for (int i = 0; i < codeLength; i++) {
      // Chọn một chữ số ngẫu nhiên từ chuỗi 'digits'
      final randomIndex = random.nextInt(digits.length);
      code += digits[randomIndex];
    }

    return code;
  }

  static String removeDomainFromEmail(String email) {
    // Kiểm tra xem email có chứa '@' không
    if (email.contains('@')) {
      // Tách phần username trước ký tự '@'
      List<String> parts = email.split('@');
      // Trả về phần đầu tiên của list (tức là phần username)
      return parts.first;
    } else {
      // Nếu không chứa '@', trả về email ban đầu
      return email;
    }
  }

  static void showIconDialog(
    String title,
    String message, {
    Widget? imageWidget,
    VoidCallback? onTap,
  }) =>
      Get.dialog(
        AlertDialog(
          title:
              imageWidget ?? const Icon(Icons.done), //add your icon/image here
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBoldStyle.copyWith(
                  color: Colors.black,
                  fontSize: Dimens.fontSize24,
                ),
              ),
              SizedBox(height: 10.w),
              Text(message,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regularStyle.copyWith(
                    color: AppColors.mineShaft,
                    fontSize: Dimens.fontSize16,
                  )),
              SizedBox(height: 20.w),
            ],
          ),
        ),
        barrierDismissible: false,
      );

  static void timePicker(
    Function(String time) onSelectTime, {
    TimeOfDay? initialTime,
  }) {
    showTimePicker(
      context: Get.overlayContext!,
      initialTime: initialTime ??
          TimeOfDay.fromDateTime(
            DateTime.now(),
          ),
    ).then((v) {
      if (v != null) {
        final _now = DateTime.now();
        final _dateTime = DateTime(
          _now.year,
          _now.month,
          _now.day,
          v.hour,
          v.minute,
        );

        onSelectTime(_dateTime.formatedDate(dateFormat: 'hh:mm aa'));
      }
    });
  }

  static String getRandomString(
    int length, {
    bool isNumber = true,
  }) {
    final _chars = isNumber ? '1234567890' : 'abcdefghijklmnopqrstuvwxyz';
    final _rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(
            _chars.length,
          ),
        ),
      ),
    );
  }

  static String formatTimeAgo(String time) {
    DateTime dateTime = DateTime.parse(time);

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 5) {
      return '${difference.inDays} ngày trước';
    } else {
      // Format the DateTime object using intl library
      final formatter = DateFormat('dd/MM/yyyy HH:mm');
      return formatter.format(dateTime);
    }
  }

  static String getDaySign(int dayOfWeek) {
    switch (dayOfWeek) {
      case DateTime.monday:
        return 'Thứ 2';
      case DateTime.tuesday:
        return 'Thứ 3';
      case DateTime.wednesday:
        return 'Thứ 4';
      case DateTime.thursday:
        return 'Thứ 5';
      case DateTime.friday:
        return 'Thứ 6';
      case DateTime.saturday:
        return 'Thứ 7';
      case DateTime.sunday:
        return 'CN';
      default:
        return '';
    }
  }

  static String getLabel(int label) {
    if (label == 1) {
      return "Dọn dẹp nhà theo giờ";
    } else if (label == 2) {
    } else if (label == 3) {
    } else if (label == 4) {
    } else if (label == 5) {
    } else if (label == 6) {
    } else if (label == 7) {}
    return "Unknown label";
  }

  static String getCityFromAddress(String address) {
    List<String> addressParts = address.split(','); // Tách chuỗi thành các phần

    // Lấy thành phố từ phần tử thứ hai trong mảng
    String city = addressParts.length >= 2 ? addressParts[1].trim() : '';
    city = city.contains('Huyện') ? city.replaceAll('Huyện', '').trim() : city;
    return city;
  }

  static String getHour(String time) {
    List<String> parts = time.split(',');

    String hourPart = parts[0].trim();
    return hourPart;
  }

  static String getHourStart(String time) {
    List<String> parts = time.split(',');

    String hourPart = parts[1].trim();
    return hourPart;
  }

  static String replaceTodayWithDayOfWeek(String selectedDateStr) {
    final DateTime now = DateTime.now();
    final String todayStr = DateFormat('dd/MM/yyyy').format(now);
    final String todayDayOfWeek = getDaySign(now.weekday);

    if (selectedDateStr.contains('Hôm nay')) {
      return selectedDateStr.replaceFirst('Hôm nay', todayDayOfWeek);
    } else if (selectedDateStr.contains(todayStr)) {
      return selectedDateStr.replaceFirst(
          todayStr, '$todayDayOfWeek, $todayStr');
    }

    return selectedDateStr;
  }

  static void loadingDialog() {
    Utils.closeDialog();

    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(22.w),
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: 10.borderRadius),
          child: const CupertinoActivityIndicator(),
        ),
      ),
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  static void closeSnackbar() {
    if (Get.isSnackbarOpen == true) {
      Get.back();
    }
  }

  static void showSnackbar(
    String? message,
    String? icon,
    Color? colors,
  ) {
    closeSnackbar();

    Get.rawSnackbar(
        icon: icon != null
            ? SvgPicture.asset(
                icon,
                width: 18.w,
                height: 18.h,
                color: colors ?? null,
              )
            : null,
        boxShadows: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 6.r,
            spreadRadius: -2,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 15.r,
            spreadRadius: -3,
            offset: const Offset(0, 4),
          ),
        ],
        backgroundColor: AppColors.white,
        messageText: Text(
          message!,
          style: AppTextStyle.textsmallStyle,
        ),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 50).r,
        borderRadius: 9.r);
  }

  static void closeKeyboard() {
    final currentFocus = Get.focusScope!;
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void goBackToScreen(String routeName) {
    Get.until(
      (route) => route.settings.name == routeName,
    );
  }

  static Future<void> showImagePicker({
    required Function(File image) onGetImage,
  }) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage(source: 2).then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 60.w,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        Strings.gallery,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldStyle.copyWith(
                          color: AppColors.mineShaft,
                          fontSize: Dimens.fontSize16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    getImage().then((v) {
                      if (v != null) {
                        onGetImage(v);
                        Get.back();
                      }
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 60.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        Strings.camera,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldStyle.copyWith(
                          color: AppColors.mineShaft,
                          fontSize: Dimens.fontSize16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<File?> getImage({int source = 1}) async {
    // File? croppedFile;
    // final picker = ImagePicker();

    // final pickedFile = await picker.pickImage(
    //   source: source == 1 ? ImageSource.camera : ImageSource.gallery,
    //   imageQuality: 60,
    // );

    // if (pickedFile != null) {
    //   final image = File(pickedFile.path);

    //   croppedFile = await ImageCropper().cropImage(
    //     compressQuality: 50,
    //     sourcePath: image.path,
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.square,
    //       CropAspectRatioPreset.ratio3x2,
    //       CropAspectRatioPreset.original,
    //       CropAspectRatioPreset.ratio4x3,
    //       CropAspectRatioPreset.ratio16x9
    //     ],
    //     androidUiSettings: const AndroidUiSettings(
    //       toolbarColor: Colors.transparent,
    //       toolbarWidgetColor: Colors.transparent,
    //       initAspectRatio: CropAspectRatioPreset.original,
    //       lockAspectRatio: false,
    //     ),
    //     iosUiSettings: const IOSUiSettings(
    //       minimumAspectRatio: 0.1,
    //       aspectRatioLockDimensionSwapEnabled: true,
    //     ),
    //   );
    // }

    return File("");
  }

  static String? birthDateValidator(String? value) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    if (value != null) {
      String str1 = value;
      List<String> str2 = str1.split('/');
      String month = str2.isNotEmpty ? str2[0] : '';
      String day = str2.length > 1 ? str2[1] : '';
      String year = str2.length > 2 ? str2[2] : '';
      if (value.isEmpty) {
        return 'BirthDate is Empty';
      } else if (int.parse(month) > 13) {
        return 'Month is invalid';
      } else if (int.parse(day) > 32) {
        return 'Day is invalid';
      } else if ((int.parse(year) > int.parse(formatted))) {
        return 'Year is invalid';
      } else if ((int.parse(year) < 1920)) {
        return 'Year is invalid';
      }
    }
    return null;
  }

  static String shortenName(String? nameRaw,
      {int nameLimit = 2, bool addDots = false}) {
    //* Limiting val should not be gt input length (.substring range issue)

    if (nameRaw != null) {
      final max = nameLimit < nameRaw.length ? nameLimit : nameRaw.length;
      //* Get short name
      final name = nameRaw.substring(0, max);
      //* Return with '..' if input string was sliced
      if (addDots && nameRaw.length > max) return name.toUpperCase();
      return name.toUpperCase();
    }
    return "_";
  }

  static String formatNumber(int number) {
    String formattedNumber = number.toString();
    if (formattedNumber.length > 3) {
      for (int i = formattedNumber.length - 3; i > 0; i -= 3) {
        formattedNumber =
            '${formattedNumber.substring(0, i)},${formattedNumber.substring(i)}';
      }
    }
    return formattedNumber;
  }

  static String formatNumberK(dynamic number) {
    if (number is int) {
      if (number >= 1000 && number < 1000000) {
        return '${(number / 1000).toStringAsFixed(0)}k';
      } else if (number >= 1000000) {
        return '${(number / 1000000).toStringAsFixed(0)}M';
      } else {
        return number.toString();
      }
    } else if (number is double) {
      if (number >= 1000 && number < 1000000) {
        return '${(number / 1000).toStringAsFixed(1)}k';
      } else if (number >= 1000000) {
        return '${(number / 1000000).toStringAsFixed(1)}M';
      } else {
        return number.toString();
      }
    }
    return number.toString();
  }

// Hàm nhập tọa độ của hai địa điểm và xuất ra khoảng cách giữa chúng
  static double calculateDistanceBetweenLocations(
      Location location1, Location location2) {
    double distance = calculateDistanceInKm(location1, location2);
    return distance;
  }

// Hàm tính khoảng cách giữa hai điểm dựa trên tọa độ GPS sử dụng công thức Haversine
  static double calculateDistanceInKm(Location start, Location end) {
    const double earthRadius = 6371.0; // Đường kính trái đất trong km

    // Chuyển đổi tọa độ từ độ sang radian
    double startLatRadians = degreesToRadians(start.latitude);
    double endLatRadians = degreesToRadians(end.latitude);
    double latDiffRadians = degreesToRadians(end.latitude - start.latitude);
    double lngDiffRadians = degreesToRadians(end.longitude - start.longitude);

    // Áp dụng công thức Haversine
    double a = pow(sin(latDiffRadians / 2), 2) +
        cos(startLatRadians) *
            cos(endLatRadians) *
            pow(sin(lngDiffRadians / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Tính khoảng cách
    double distance = earthRadius * c;
    return distance;
  }

// Hàm chuyển đổi độ sang radian
  static double degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  static String distance(
      double latStar, double lngStart, double latEnd, double lngEnd) {
    // Nhập tọa độ của hai địa điểm
    Location location1 = Location(latStar, lngStart); // Ví dụ: New York City
    Location location2 = Location(latEnd, lngEnd); // Ví dụ: Los Angeles

    // Tính và in ra khoảng cách giữa hai điểm
    double distance = calculateDistanceBetweenLocations(location1, location2);
    print('Khoảng cách giữa hai điểm là: $distance km');
    return distance.toString();
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location(this.latitude, this.longitude);
}
