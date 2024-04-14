import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/home/view/dash_board/student_home_page.dart';
import 'package:we_easy/app/modules/job/view/job_view.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';

import '../../../common/util/exports.dart';
import '../../../data/firebase/firestore_service/firestire_service_get.dart';
import '../../../data/firebase/firestore_service/firestore_service_add.dart';
import '../../../data/firebase/firestore_service/firestore_service_put.dart';
import '../../../data/model/all_job_models/all_job_cty_model.dart';
import '../../../data/model/all_job_models/all_job_model.dart';
import '../../../data/model/job_models/job_model.dart';
import '../../../data/model/user_models/user_model.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController
    with StateMixin<AllJobModel>, SingleGetTickerProviderMixin {
  final FirestoreServiceGet _firestoreServiceGet = FirestoreServiceGet();
  final FirestoreServiceAdd _firestoreServiceAdd = FirestoreServiceAdd();
  final FirestoreServicePut _firestoreServicePut = FirestoreServicePut();
  final Rx<int> selectedIndex = 0.obs;

  var selectedIndexx = 0.obs;
  late TabController tabController;
  int? permission = Storage.getValue<int>('permission');
  String? email = Storage.getValue<String>('email');
  var textPermission = 0.obs;
  var isUngTuyen = false.obs;
  late final List<Widget> screens;

  late final List<UserModel> listUserModel = [];
  late final List<AllJobModel> listAllJobModel = [];
  late final List<AllJobCtyModel> listAllJobCtyModel = [];
  late final List<JobModel> listJobModel = [];

  TextEditingController search = TextEditingController();
  void selectTab(int index) {
    selectedIndexx.value = index;
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    getUser();
    getCareer();
    getPostJob('');
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> getCareer() async {
    List<DocumentSnapshot> snapshot =
        await _firestoreServiceGet.searchText('job', '');

    if (snapshot.isNotEmpty) {
      listJobModel.clear(); // Xóa dữ liệu cũ
      for (DocumentSnapshot document in snapshot) {
        // Truy cập dữ liệu của mỗi tài liệu
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        // Thêm dữ liệu của mỗi tài liệu vào danh sách
        JobModel jobModel = JobModel.fromJson(data);
        listJobModel.add(jobModel); // Thêm vào danh sách quan sát
      }
      for (var i = 0; i < listJobModel.length; i++) {
        print(listJobModel[i].name);
      }
      print(listJobModel.map((job) => job.name!).toList());
    } else {
      debugPrint('Không có tài liệu nào trong bảng career hoặc đã xảy ra lỗi.');
    }
  }

  Future<void> getPostJob(String searchText) async {
    try {
      listAllJobModel.clear();
      change(null, status: RxStatus.loading());
      List<CombinedData> combinedDataList =
          await _firestoreServiceGet.searchTextAll(searchText);

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
          AllJobModel allJobModel = AllJobModel.fromJson(combinedJson);
          listAllJobModel.add(allJobModel);

          change(allJobModel, status: RxStatus.success());
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

  Future<void> getPostJobALL(String cty) async {
    try {
      listAllJobCtyModel.clear();
      List<CombinedData> combinedDataList =
          await _firestoreServiceGet.searchTextAllCty(cty);

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
          AllJobCtyModel allJobCtyModel = AllJobCtyModel.fromJson(combinedJson);
          listAllJobCtyModel.add(allJobCtyModel);
        }
      } else {
        debugPrint(
            'Không có tài liệu nào trong bảng career hoặc đã xảy ra lỗi.');
      }
    } catch (e) {
      print('Error getting post job: $e');
    }
  }

  Future<void> getUser() async {
    listUserModel.clear();
    DocumentSnapshot? snapshot = await _firestoreServiceGet.getUser(email!);
    if (snapshot != null && snapshot.exists) {
      // Document exists, you can access its data
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      UserModel userModel = UserModel.fromJson(data);
      listUserModel.add(userModel);
    } else {
      debugPrint('Tài liệu không tồn tại hoặc đã xảy ra lỗi.');
    }
  }

  Future<void> getJob(String id) async {
    if (permission == 1) return;
    bool isId = await _firestoreServiceGet.isNameExist(id, email!, 'iView');
    bool isIdUT =
        await _firestoreServiceGet.isNameExist(id, email!, 'recruitment');
    isUngTuyen.value = isIdUT;
    print(isId);
    if (isId != true) {
      DocumentSnapshot<Object?>? jobSnapshot =
          await _firestoreServiceGet.getJob(id);
      if (jobSnapshot != null && jobSnapshot.exists) {
        Map<String, dynamic> jobData =
            jobSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> processedJobData = {};
        jobData.forEach((key, value) {
          if (value is Timestamp) {
            processedJobData[key] = value.toDate().millisecondsSinceEpoch;
          } else {
            processedJobData[key] = value;
          }
        });
        String jobJson = jsonEncode(processedJobData);
        Map<String, dynamic> jobDataa = jsonDecode(jobJson);

        int viewValue = jobDataa['view'];
        viewValue += 1;
        await _firestoreServicePut.updateView(id, viewValue);
        Map<String, dynamic> newData = {
          'id': email,
        };
        await _firestoreServiceAdd.addDocument(id, newData, 'iView');
      }
    } else {
      debugPrint('Không có tài liệu nào hoặc đã xảy ra lỗi.');
    }
  }

  Future<void> postUngtuyen(String id) async {
    Map<String, dynamic> newData = {'id': email, 'status': 0};
    Map<String, dynamic> newDataU = {'id': email, 'status': 0};
    await _firestoreServiceAdd.addDocumentV(id, newData, 'recruitment', email!);

    await _firestoreServiceAdd.addDocumentU(
        email!, newDataU, 'recruitment', id);
    Get.back();
    getPostJob('');
    return Utils.showSnackbar(
      'Bạn đã ứng tuyển thành công',
      AppImages.iconCircleCheck,
      AppColors.kSuccess600Color,
    );
  }

  HomeController() {
    textPermission.value = permission!;
    screens = [
      const StudentHomePage(),
      permission == 0 ? JobView(job: true.obs) : JobView(job: false.obs),
      Center(
        child: ButtonWidget(
          onTap: () async {
            FirebaseAuth.instance.signOut();
            Get.offAllNamed(Routes.welcome);
            await Storage.removeValue('permission');
          },
          text: 'Đăng xuất',
        ),
      ),
    ];
  }
}
