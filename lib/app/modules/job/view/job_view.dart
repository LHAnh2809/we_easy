import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/job/view/widgets/corporate/corporate_work_page.dart';
import 'package:we_easy/app/modules/job/view/widgets/student/student_work_page.dart';

import '../controller/job_controller.dart';

class JobView extends GetView<JobController> {
  final RxBool job;
  const JobView({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isJob.value = job.value;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: controller.isJob.value
              ? const StudentWorkPage()
              : const CorporateWorkPage(),
        ),
      ),
    );
  }
}
