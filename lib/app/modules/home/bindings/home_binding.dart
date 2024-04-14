import 'package:get/get.dart';

import '../../job/controller/job_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<JobController>(
      () => JobController(),
    );
  }
}
