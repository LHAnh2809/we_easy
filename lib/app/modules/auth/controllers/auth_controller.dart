import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_easy/app/common/util/exports.dart';
import 'package:we_easy/app/data/firebase/firebase_auth/firebase_auth_service.dart';
import 'package:we_easy/app/data/model/career_models/career_model.dart';

import '../../../common/util/dialog_util.dart';
import '../../../common/util/navigator.dart';
import '../../../common/util/validators.dart';
import '../../../data/firebase/firestore_service/firestire_service_get.dart';
import '../../../data/firebase/firestore_service/firestore_service_add.dart';
import '../../../data/model/user_models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../widgets/custom_text_field.dart';

class AuthController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreServiceAdd _firestoreServiceAdd = FirestoreServiceAdd();
  final FirestoreServiceGet _firestoreServiceGet = FirestoreServiceGet();
  RxBool isLogin = false.obs;
  RxBool obscureTextPass = true.obs;
  RxBool obscureTextRePass = true.obs;
  RxBool isPrivacy = true.obs;
  var isLoading = false.obs;
  var verticalValAutomatic = 'Sinh viên'.obs;
  var career = 'Ngành nghề'.obs;
  var selectedCount = 0.obs;
  final RxString dateBirth = "".obs;

  var imageUrl = "".obs;
  var selectedCareers = <String>['Ngành nghề'].obs;

  final List<String> options = ['Nam', 'Nữ'];

  final RxString selectedOption = RxString('Giới tính');

  var listCareerModel = <CareerModel>[].obs;
  var listUserModel = <UserModel>[].obs;

  RxList<bool> isCheckedList = <bool>[].obs;

  Rx<File?> imageFile = Rx<File?>(null);
  TextEditingController companyName = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController businessRegistration = TextEditingController();
  TextEditingController businessAddress = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController ngaySinh = TextEditingController();
  TextEditingController gioiTinh = TextEditingController();
  TextEditingController tinhTrangHonNhan = TextEditingController();
  TextEditingController lop = TextEditingController();
  TextEditingController khoaHoc = TextEditingController();
  TextEditingController sinhVienNamMay = TextEditingController();
  TextEditingController chuyenNganh = TextEditingController();
  TextEditingController soTruong = TextEditingController();
  TextEditingController kinhNghiemLamViec = TextEditingController();
  TextEditingController kyNangThanhThao = TextEditingController();

  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController forgotPassword = TextEditingController();
  TextEditingController sex = TextEditingController();
  var searchText = ''.obs;

  final keyEmail = GlobalKey<TextFieldWidgetState>();
  final keyPassword = GlobalKey<TextFieldWidgetState>();
  final keyConfirmPassword = GlobalKey<TextFieldWidgetState>();
  final KeyCompanyName = GlobalKey<TextFieldWidgetState>();
  final keyBusinessAddress = GlobalKey<TextFieldWidgetState>();
  final keyPhone = GlobalKey<TextFieldWidgetState>();
  final keyForgotPassword = GlobalKey<TextFieldWidgetState>();

  final keyName = GlobalKey<TextFieldWidgetState>();
  final keyngaySinh = GlobalKey<TextFieldWidgetState>();
  final keygioiTinh = GlobalKey<TextFieldWidgetState>();
  final keytinhTrangHonNhan = GlobalKey<TextFieldWidgetState>();
  final keylop = GlobalKey<TextFieldWidgetState>();
  final keykhoaHoc = GlobalKey<TextFieldWidgetState>();
  final keysinhVienNamMay = GlobalKey<TextFieldWidgetState>();
  final keychuyenNganh = GlobalKey<TextFieldWidgetState>();
  final keysoTruong = GlobalKey<TextFieldWidgetState>();
  final keykinhNghiemLamViec = GlobalKey<TextFieldWidgetState>();
  final keykyNangThanhThao = GlobalKey<TextFieldWidgetState>();
  final keyanh = GlobalKey<TextFieldWidgetState>();

  resgisterAccount(context) {
    if (verticalValAutomatic.value == 'Sinh viên') {
      sinhVien(context);
    } else {
      doanhNghiep(context);
    }
  }

  void sinhVien(context) async {
    if (name.text.isNullOrEmpty) {
      keyName.currentState?.setError(Strings.errorFirstName);

      return;
    } else if (Validators.validateName(name.text)) {
      keyName.currentState?.setError(Strings.errorNameRegex);

      return;
    }

    // Kiểm tra Ngày sinh
    if (dateBirth.value.isNullOrEmpty) {
      keyngaySinh.currentState?.setError(Strings.invalidDateOfBirth);

      return;
    }
// Kiểm tra Giới tính
    if (imageFile.value!.path.isNullOrEmpty) {
      keyanh.currentState?.setError(Strings.errorGender);
      return;
    }
    // Kiểm tra Giới tính
    if (sex.text.isNullOrEmpty) {
      keygioiTinh.currentState?.setError(Strings.errorGender);
      return;
    }

    // Kiểm tra Tình trạng hôn nhân
    if (tinhTrangHonNhan.text.isNullOrEmpty) {
      keytinhTrangHonNhan.currentState?.setError(Strings.errorMaritalStatus);
      return;
    }

    // Kiểm tra Lớp
    if (lop.text.isNullOrEmpty) {
      keylop.currentState?.setError(Strings.errorClass);
      return;
    }

    // Kiểm tra Khóa học
    if (khoaHoc.text.isNullOrEmpty) {
      keykhoaHoc.currentState?.setError(Strings.errorCourse);
      return;
    }

    // Kiểm tra Sinh viên năm mấy
    if (sinhVienNamMay.text.isNullOrEmpty) {
      keysinhVienNamMay.currentState?.setError(Strings.errorStudentYear);
      return;
    }

    // Kiểm tra Chuyên ngành
    if (chuyenNganh.text.isNullOrEmpty) {
      keychuyenNganh.currentState?.setError(Strings.errorMajor);
      return;
    }

    // Kiểm tra Sở trường
    if (soTruong.text.isNullOrEmpty) {
      keysoTruong.currentState?.setError(Strings.errorStrengths);
      return;
    }

    // Kiểm tra Kinh nghiệm làm việc
    if (kinhNghiemLamViec.text.isNullOrEmpty) {
      keykinhNghiemLamViec.currentState?.setError(Strings.errorWorkExperience);
      return;
    }

    // Kiểm tra Kỹ năng thành thạo
    if (kyNangThanhThao.text.isNullOrEmpty) {
      keykyNangThanhThao.currentState?.setError(Strings.errorSkills);
      return;
    }
    if (getSelectedCareersString().isNullOrEmpty) {
      return;
    }
    if (phone.text.isNullOrEmpty) {
      keyPhone.currentState?.setError(Strings.errorPhone);
    } else if (!GetUtils.isPhoneNumber(phone.text)) {
      keyPhone.currentState?.setError(Strings.invalidEmail);
    } else if (email.text.isNullOrEmpty) {
      keyEmail.currentState?.setError(Strings.errorEmail);
    } else if (!GetUtils.isEmail(email.text)) {
      keyEmail.currentState?.setError(Strings.invalidEmail);
    } else if (password.text.isNullOrEmpty) {
      keyPassword.currentState?.setError(Strings.errorPass);
    } else if (password.text.length < 8) {
      keyPassword.currentState?.setError(Strings.errorPassLong);
    } else if (confirmPassword.text.isNullOrEmpty) {
      keyConfirmPassword.currentState?.setError(Strings.errorRePass);
    } else if (confirmPassword.text != password.text) {
      keyConfirmPassword.currentState?.setError(Strings.errorRePassMath);
    } else if (!isPrivacy.value) {
      DialogUtil.alert(context, 'Đồng ý quyền riêng tư và các điều khoản');
    } else {
      isLoading.value = true;
      String imageName = imageFile.value!.path;
      final imageUrlt = await Utils.uploadFileToFirebaseStorage(
        "studient_card",
        imageName,
        '${Utils.removeDomainFromEmail(email.text)}.png',
      );

      // ignore: unnecessary_null_comparison
      if (imageUrlt != null) {
        imageUrl.value = imageUrlt.toString();
      } else {
        print('Failed to upload image.');
      }
      User? user = await _authService.singUpWithEmailAndPassword(
        email.text,
        password.text,
      );
      if (user != null) {
        await _firestoreServiceAdd
            .addMoreBusinesses(
          Utils.generateCandidateCode(),
          email.text,
          '',
          '',
          '',
          phone.text,
          name.text,
          dateBirth.value,
          sex.text,
          tinhTrangHonNhan.text,
          lop.text,
          khoaHoc.text,
          sinhVienNamMay.text,
          chuyenNganh.text,
          soTruong.text,
          kinhNghiemLamViec.text,
          kyNangThanhThao.text,
          imageUrl.value,
          getSelectedCareersString(),
          0,
        )
            .then((value) async {
          listUserModel.clear();
          DocumentSnapshot? snapshot =
              await _firestoreServiceGet.getUser(email.text);
          if (snapshot != null && snapshot.exists) {
            // Document exists, you can access its data
            Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            UserModel userModel = UserModel.fromJson(data);
            listUserModel.add(userModel);

            await _savedToken(
              data['permission'],
            );
            clearText();
            Get.offAllNamed(Routes.home);
            isLoading.value = false;

            return Utils.showSnackbar(
              'Bạn đã tạo tài khoản thành công',
              AppImages.iconCircleCheck,
              AppColors.kSuccess600Color,
            );
          } else {
            debugPrint('Tài liệu không tồn tại hoặc đã xảy ra lỗi.');
          }
        });
      }
    }
  }

  void doanhNghiep(context) async {
    if (companyName.text.isNullOrEmpty) {
      KeyCompanyName.currentState?.setError(Strings.errorFirstName);
    } else if (Validators.validateName(companyName.text)) {
      KeyCompanyName.currentState?.setError(Strings.errorNameRegex);
    } else if (phone.text.isNullOrEmpty) {
      keyPhone.currentState?.setError(Strings.errorPhone);
    } else if (!GetUtils.isPhoneNumber(phone.text)) {
      keyPhone.currentState?.setError(Strings.invalidEmail);
    } else if (email.text.isNullOrEmpty) {
      keyEmail.currentState?.setError(Strings.errorEmail);
    } else if (!GetUtils.isEmail(email.text)) {
      keyEmail.currentState?.setError(Strings.invalidEmail);
    } else if (password.text.isNullOrEmpty) {
      keyPassword.currentState?.setError(Strings.errorPass);
    } else if (password.text.length < 8) {
      keyPassword.currentState?.setError(Strings.errorPassLong);
    } else if (confirmPassword.text.isNullOrEmpty) {
      keyConfirmPassword.currentState?.setError(Strings.errorRePass);
    } else if (confirmPassword.text != password.text) {
      keyConfirmPassword.currentState?.setError(Strings.errorRePassMath);
    } else if (!isPrivacy.value) {
      DialogUtil.alert(context, 'Đồng ý quyền riêng tư và các điều khoản');
    } else {
      isLoading.value = true;
      User? user = await _authService.singUpWithEmailAndPassword(
        email.text,
        password.text,
      );
      if (user != null) {
        await _firestoreServiceAdd
            .addMoreBusinesses(
          Utils.generateCandidateCode(),
          email.text,
          companyName.text,
          businessRegistration.text,
          businessAddress.text,
          phone.text,
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          '',
          1,
        )
            .then((value) async {
          listUserModel.clear();
          DocumentSnapshot? snapshot =
              await _firestoreServiceGet.getUser(email.text);
          if (snapshot != null && snapshot.exists) {
            // Document exists, you can access its data
            Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            UserModel userModel = UserModel.fromJson(data);
            listUserModel.add(userModel);

            await _savedToken(
              data['permission'],
            );
            clearText();
            Get.offAllNamed(Routes.home);
            isLoading.value = false;

            return Utils.showSnackbar(
              'Bạn đã tạo tài khoản thành công',
              AppImages.iconCircleCheck,
              AppColors.kSuccess600Color,
            );
          } else {
            debugPrint('Tài liệu không tồn tại hoặc đã xảy ra lỗi.');
          }
        });
      }
    }
  }

  Future<void> getCareer(String searchText) async {
    List<DocumentSnapshot> snapshot =
        await _firestoreServiceGet.searchText('career', searchText);

    if (snapshot.isNotEmpty) {
      listCareerModel.clear(); // Xóa dữ liệu cũ
      for (DocumentSnapshot document in snapshot) {
        // Truy cập dữ liệu của mỗi tài liệu
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        // Thêm dữ liệu của mỗi tài liệu vào danh sách
        CareerModel careerModel = CareerModel.fromJson(data);
        listCareerModel.add(careerModel); // Thêm vào danh sách quan sát
      }
      initializeCheckedList();
    } else {
      debugPrint('Không có tài liệu nào trong bảng career hoặc đã xảy ra lỗi.');
    }
  }

  signInAccount(context) async {
    User? user = await _authService.singInWithEmailAndPassword(
      email.text,
      password.text,
    );
    if (user != null) {
      listUserModel.clear();
      DocumentSnapshot? snapshot =
          await _firestoreServiceGet.getUser(email.text);
      if (snapshot != null && snapshot.exists) {
        // Document exists, you can access its data
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        UserModel userModel = UserModel.fromJson(data);
        listUserModel.add(userModel);

        await _savedToken(
          data['permission'],
        );
        clearText();
        Get.offAllNamed(Routes.home);
      } else {
        debugPrint('Tài liệu không tồn tại hoặc đã xảy ra lỗi.');
      }
    }
  }

  clearText() {
    email.text = "";
    password.text = "";
    confirmPassword.text = "";
    companyName.text = "";
    businessRegistration.text = "";
    businessAddress.text = "";
    phone.text = "";
    forgotPassword.text = "";
    phone.text = "";
    name.text = "";
    dateBirth.value = "";
    gioiTinh.text = "";
    tinhTrangHonNhan.text = "";
    lop.text = "";
    khoaHoc.text = "";
    sinhVienNamMay.text = "";
    chuyenNganh.text = "";
    soTruong.text = "";
    kinhNghiemLamViec.text = "";
    kyNangThanhThao.text = "";
    imageUrl.value = "";
    imageFile.value = null;
    obscureTextPass(true);
    obscureTextRePass(true);
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  _savedToken(int value) async {
    await Storage.saveValue('permission', value);
    await Storage.saveValue('email', email.text);
  }

  selectDate() {
    goDatePicker(
      onDateChanged: (DateTime? selectedDate) {
        // Xử lý ngày được chọn ở đây
        if (selectedDate != null) {
          String formattedDate = selectedDate.formatDMY;
          dateBirth.value = formattedDate;
        } else {
          debugPrint('No date selected');
        }
      },
    );
  }

  void initializeCheckedList() {
    isCheckedList.clear();
    for (int i = 0; i < listCareerModel.length; i++) {
      isCheckedList.add(false);
    }
  }

  void toggleCareerSelection(int index, bool selected) {
    final model = listCareerModel[index];
    if (selected) {
      if (!selectedCareers.contains(model.name)) {
        selectedCareers.add(model.name!);
      }
    } else {
      selectedCareers.remove(model.name);
    }
  }

  String getSelectedCareersString() {
    return selectedCareers.join(', ');
  }

  void postForgotPassword() {
    if (forgotPassword.text.isNullOrEmpty) {
      keyForgotPassword.currentState?.setError(Strings.errorEmail);
    } else {
      // _apiHelper.forgotPassword(forgotPassword.text.trim()).futureValue(
      //     (value) {
      //   DialogUtil.alert(Get.context!,'Kiểm tra email quên mật khẩu');
      // }, onError: (e) {
      //   DialogUtil.alert(Get.context!, e);
      // }, retryFunction: () {});
    }
  }
}
