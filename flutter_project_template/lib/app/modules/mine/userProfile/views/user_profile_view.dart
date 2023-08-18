import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
