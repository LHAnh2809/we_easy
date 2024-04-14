import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/common/util/exports.dart';
import 'package:we_easy/app/data/firebase/firestore_service/firestore_service_add.dart';
import 'package:we_easy/app/data/model/user_models/user_model.dart';
import 'package:we_easy/app/data/model/user_models/user_ut_model.dart';
import 'package:we_easy/app/modules/home/controllers/home_controller.dart';

import '../../../common/util/navigator.dart';
import '../../../data/firebase/firestore_service/firestire_service_get.dart';

import '../../../data/model/job_models/job_model.dart';
import '../../../data/model/posted_job_models/posted_job_model.dart';

class JobController extends GetxController
    with StateMixin<PostedJobModel>, SingleGetTickerProviderMixin {
  late HomeController homeController;
  late TabController tabController;
  late TabController tabControllerr;
  final FirestoreServiceAdd _firestoreServiceAdd = FirestoreServiceAdd();
  final FirestoreServiceGet _firestoreServiceGet = FirestoreServiceGet();
  final List<String> options = [
    'Thỏa thuận',
    'Toàn thời gian cố định',
    'Bán thời gian'
  ];
  final List<String> optionsGT = ['Không yêu cầu', 'Nam', 'Nữ'];
  final List<String> optionsKN = [
    'Không yêu cầu',
    'Yều cầu 1 năm kinh nghiệm',
    'Yều cầu 2 năm kinh nghiệm',
    'Yều cầu 3 năm kinh nghiệm',
    'Yều cầu 4 năm kinh nghiệm',
    'Yều cầu 5 năm kinh nghiệm',
  ];
  final List<String> optionsBC = [
    'Không yêu cầu',
    '9/12',
    '12/12',
  ];
  var isLoading = false.obs;
  var isCheck = false.obs;
  var textEr = 'NaN'.obs;
  var textNameCTY = 'NaN'.obs;
  final RxString selectedOption = RxString('Thỏa thuận');
  final RxString selectedOptionKM = RxString('Không yêu cầu');
  final RxString selectedOptionBC = RxString('Không yêu cầu');
  final RxString selectedOptionGT = RxString('Không yêu cầu');
  var selectedCareers = <String>['Ngành nghề'].obs;
  final RxString dateBirth = "".obs;
  TextEditingController title = TextEditingController();
  TextEditingController mucLuong = TextEditingController();
  TextEditingController chucVu = TextEditingController();
  TextEditingController soLuong = TextEditingController();
  TextEditingController hoaHong = TextEditingController();
  TextEditingController thoiGianThuViec = TextEditingController();
  TextEditingController motaCongViec = TextEditingController();
  TextEditingController yeucauCongViec = TextEditingController();
  TextEditingController quyenLoi = TextEditingController();
  TextEditingController hoso = TextEditingController();
  final Timestamp now = Timestamp.now();
  late final List<PostedJobModel> listPostedJobModel = [];
  late final List<UserUTModel> listUserUTModel = [];
  String? email = Storage.getValue<String>('email');
  int? permission = Storage.getValue<int>('permission');
  Future<void> getPostJob() async {
    try {
      listPostedJobModel.clear();
      change(null, status: RxStatus.loading());
      List<CombinedData> combinedDataList;
      if (selectedIndex == 0) {
        combinedDataList = await _firestoreServiceGet.getPostedJob();
      } else {
        combinedDataList = await _firestoreServiceGet.getPostedJobExpired();
      }

      if (combinedDataList.isNotEmpty) {
        for (CombinedData combinedData in combinedDataList) {
          // Truy cập dữ liệu của mỗi tài liệu
          Map<String, dynamic> userData = combinedData.userData;
          Map<String, dynamic> postData = combinedData.postData;
          String postId = combinedData.postId;

          // Thực hiện xử lý với dữ liệu của cả hai bảng
          // Ghép hai chuỗi JSON thành một
          Map<String, dynamic> combinedJson = {
            ...userData,
            ...postData,
            'postId': postId,
          };
          PostedJobModel postedJobModel = PostedJobModel.fromJson(combinedJson);
          listPostedJobModel.add(postedJobModel);

          change(postedJobModel, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.empty());
        debugPrint(
            'Không có tài liệu nào trong bảng career hoặc đã xảy ra lỗi.');
      }
    } catch (e) {
      change(null, status: RxStatus.error());
      print('Error getting post job: $e');
    }
  }

  void addJob() async {
    isLoading.value = true;
    if (title.text.isNullOrEmpty) {
      isCheck.value = true;
      textEr.value = 'Tiêu đề Tuyển dụng không thể bỏ trống';
      isLoading.value = false;
      return;
    } else if (soLuong.text.isNullOrEmpty) {
      isCheck.value = true;
      textEr.value = 'Số lượng tuyển dụng không thể bỏ trống';
      isLoading.value = false;
      return;
    }
    if (mucLuong.text.isNullOrEmpty) {
      mucLuong.text = 'Thỏa luận';
    }
    if (dateBirth.value.isNullOrEmpty) {
      isCheck.value = true;
      textEr.value = 'Hạn hợp đồng không thể bỏ trống';
      isLoading.value = false;
      return;
    } else if (chucVu.text.isNullOrEmpty) {
      isCheck.value = true;
      textEr.value = 'Chức vụ không thể bỏ trống';
      isLoading.value = false;
      return;
    }
    if (thoiGianThuViec.text.isNullOrEmpty) {
      thoiGianThuViec.text = 'Chưa cập nhật';
    }
    if (hoaHong.text.isNullOrEmpty) {
      hoaHong.text = 'Chưa cập nhật';
    }
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user!.email;
    await _firestoreServiceAdd
        .addJob(
      userId,
      textNameCTY.value,
      title.text,
      mucLuong.text,
      dateBirth.value,
      chucVu.text,
      selectedOption.value,
      soLuong.text,
      hoaHong.text,
      thoiGianThuViec.text,
      selectedOptionKM.value,
      selectedOptionBC.value,
      selectedOptionGT.value,
      getSelectedCareersString(),
      motaCongViec.text,
      yeucauCongViec.text,
      quyenLoi.text,
      hoso.text,
      now,
    )
        .then((value) {
      clearText();
      isLoading.value = false;
      Get.back();
      return Utils.showSnackbar(
        'Bạn đã đăng tuyển dụng thành công',
        AppImages.iconCircleCheck,
        AppColors.kSuccess600Color,
      );
    });
  }

  clearText() {
    textNameCTY.value = 'NaN';
    title.text = '';
    mucLuong.text = '';
    dateBirth.value = '';
    chucVu.text = '';
    selectedOption.value = 'Thỏa thuận';
    soLuong.text = '';
    hoaHong.text = '';
    thoiGianThuViec.text = '';
    selectedOptionKM.value = 'Không yêu cầu';
    selectedOptionBC.value = 'Không yêu cầu';
    selectedOptionGT.value = 'Không yêu cầu';
    selectedCareers.value = <String>['Ngành nghề'];
    motaCongViec.text = '';
    yeucauCongViec.text = '';
    quyenLoi.text = '';
    hoso.text = '';
  }

  var selectedCount = 0.obs;
  @override
  void onInit() {
    if (permission == 0) {
      tabControllerr = TabController(length: 3, vsync: this);
      getJobU();
    } else {
      tabController = TabController(length: 2, vsync: this);
      homeController = Get.put(HomeController());
      getUser();
      getPostJob();
    }

    super.onInit();
  }

  void getUser() {
    final List<UserModel> users = homeController.listUserModel;
    textNameCTY.value = users[0].companyName!;
  }

  @override
  void onClose() {
    tabController.dispose();
    tabControllerr.dispose();
    super.onClose();
  }

  var selectedIndex = 0.obs;
  var selectedIndexx = 0.obs;
  void selectTabb(int index) {
    selectedIndexx.value = index;
    getJobU();
  }

  void selectTab(int index) {
    selectedIndex.value = index;
    getPostJob();
  }

  RxBool isJob = false.obs;

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

  RxList<bool> isCheckedList = <bool>[].obs;
  var listJobModel = <JobModel>[].obs;

  Future<void> getCareer(String searchText) async {
    List<DocumentSnapshot> snapshot =
        await _firestoreServiceGet.searchText('job', searchText);

    if (snapshot.isNotEmpty) {
      listJobModel.clear(); // Xóa dữ liệu cũ
      for (DocumentSnapshot document in snapshot) {
        // Truy cập dữ liệu của mỗi tài liệu
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        // Thêm dữ liệu của mỗi tài liệu vào danh sách
        JobModel jobModel = JobModel.fromJson(data);
        listJobModel.add(jobModel); // Thêm vào danh sách quan sát
      }
      initializeCheckedList();
    } else {
      debugPrint('Không có tài liệu nào trong bảng career hoặc đã xảy ra lỗi.');
    }
  }

  void initializeCheckedList() {
    isCheckedList.clear();
    for (int i = 0; i < listJobModel.length; i++) {
      isCheckedList.add(false);
    }
  }

  Future<void> postUngtuyen(String id, int status, String email) async {
    Map<String, dynamic> newData = {
      'status': status,
      'id': email,
    };
    Map<String, dynamic> newDataU = {
      'status': status,
      'id': id,
    };
    await _firestoreServiceAdd.addDocumentRecruitment(
        id, newData, newDataU, 'recruitment', email);
    // await _firestoreServiceAdd.addDocumentU(email!, newData, 'recruitment');
    Get.back();
    Get.back();
    getPostJob();
    if (status == 2) {
      return Utils.showSnackbar(
        'Chấp nhận ứng cử viên thành công',
        AppImages.iconCircleCheck,
        AppColors.kSuccess600Color,
      );
    } else {
      return Utils.showSnackbar(
        'Từ chối ứng cử viên thành công',
        AppImages.iconCircleCheck,
        AppColors.kRrror600Color,
      );
    }
  }

  var textUT = 0.obs;
  Future<void> getUserUT(String idJ, String postId) async {
    listUserUTModel.clear();
    textUT.value = 0;
    List<DocumentSnapshot> snapshot =
        await _firestoreServiceGet.getDataUserUT(idJ, 'recruitment');
    if (snapshot.isNotEmpty) {
      for (DocumentSnapshot document in snapshot) {
        textUT.value += 1;
        // Truy cập dữ liệu của mỗi tài liệu
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        // Thêm dữ liệu của mỗi tài liệu vào danh sách
        String json = jsonEncode(data);
        Map<String, dynamic> jobDataa = jsonDecode(json);

        String viewValue = jobDataa['id'];
        print(viewValue);
        Map<String, dynamic>? snapshot =
            await _firestoreServiceGet.getUserJob(viewValue, postId);

        if (snapshot != null) {
          // Kiểm tra xem tài liệu đã tồn tại
          if (snapshot.containsKey('parentData') &&
              snapshot.containsKey('childData')) {
            // Lấy dữ liệu từ tài liệu cha và tài liệu con
            Map<String, dynamic> parentData =
                snapshot['parentData'] as Map<String, dynamic>;
            Map<String, dynamic> childData =
                snapshot['childData'] as Map<String, dynamic>;

            // Xử lý dữ liệu ở đây
            // Ví dụ:

            String childJson = jsonEncode(childData);
            String parentJson = jsonEncode(parentData);
            Map<String, dynamic> parentMap = jsonDecode(parentJson);
            Map<String, dynamic> childMap = jsonDecode(childJson);
            int? childStatus = childMap['status'] as int?;
            Map<String, dynamic> combinedStatus = {
              'parentStatus': parentMap,
              'childStatus': childStatus,
            };

            String combinedJson = jsonEncode(combinedStatus);
            UserUTModel userUTModel = UserUTModel.fromJson(combinedStatus);
            listUserUTModel.add(userUTModel);
          } else {
            debugPrint('Dữ liệu không hợp lệ hoặc đã xảy ra lỗi.');
          }
        } else {
          debugPrint('Tài liệu không tồn tại hoặc đã xảy ra lỗi.');
        }
      }
    } else {
      debugPrint(
          'Không có tài liệu nào trong bảng recruitment hoặc đã xảy ra lỗi.');
    }
  }

  void toggleCareerSelection(int index, bool selected) {
    final model = listJobModel[index];
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

  void getJobU() async {
    change(null, status: RxStatus.loading());
    Map<String, dynamic>? snapshot =
        await _firestoreServiceGet.getJobUserU(email!, 'recruitment', email!);
    if (snapshot != null && snapshot.containsKey('results')) {
      List<DocumentSnapshot> results = (snapshot['results'] as List<dynamic>)
          .map((snapshot) => snapshot as DocumentSnapshot)
          .toList();
      if (results.length == 2) {
        DocumentSnapshot parentSnapshot = results[0];
        DocumentSnapshot childSnapshot = results[1];

        Map<String, dynamic> parentData =
            (parentSnapshot.data() as Map<String, dynamic>) ?? {};
        Map<String, dynamic> childData =
            (childSnapshot.data() as Map<String, dynamic>) ?? {};

        Map<String, dynamic> processedJobData = {};
        parentData.forEach((key, value) {
          if (value is Timestamp) {
            processedJobData[key] = value.toDate().millisecondsSinceEpoch;
          } else {
            processedJobData[key] = value;
          }
        });

        String childJson = jsonEncode(childData);
        String parentJson = jsonEncode(processedJobData);
        Map<String, dynamic> parentMap = jsonDecode(parentJson);
        Map<String, dynamic> childMap = jsonDecode(childJson);
        int? childStatus = childMap['status'] as int?;
        Map<String, dynamic> combinedStatus = {
          'parentStatus': parentMap,
          'childStatus': childStatus,
        };

        String combinedJson = jsonEncode(combinedStatus);

        // change(allJobModel, status: RxStatus.success());
        print(combinedJson);
      } else {
        change(null, status: RxStatus.empty());
        debugPrint('Dữ liệu không hợp lệ hoặc đã xảy ra lỗi.');
      }
    } else {
      change(null, status: RxStatus.error());
      debugPrint('Tài liệu không tồn tại hoặc đã xảy ra lỗi.');
    }
  }
}
