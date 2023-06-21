import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notfound_controller.dart';

class NotfoundPage extends GetView<NotfoundController> {
  const NotfoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Not Found'),
      ),
    );
  }
}
