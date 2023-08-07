import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/study_controller.dart';

class StudyView extends GetView<StudyController> {
  const StudyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
