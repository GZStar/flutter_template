import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_image_controller.dart';

class TestImageView extends GetView<TestImageController> {
  const TestImageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestImageView'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              controller.openImagePickerView(context);
            },
          )
        ],
      ),
      body: GetBuilder<TestImageController>(builder: (controller) {
        return ListView.builder(
          itemCount: controller.images.length,
          itemBuilder: (context, index) {
            return Image.asset(controller.images[index]);
          },
        );
      }),
    );
  }
}
