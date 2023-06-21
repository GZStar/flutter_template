import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/common_widget.dart';
import '../../common/widgets/input_field.dart';
import 'login_controller.dart';
import '../../common/base/base_view.dart';
import 'dart:ui' as ui show window;

class LoginView extends BaseView<LoginController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CommonWidget.appBar('login'.tr, isBackButtonEnabled: false);
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: _buildForms(context),
    );
  }

  Widget _buildForms(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              controller: controller.loginAccountController,
              keyboardType: TextInputType.phone,
              labelText: 'Phone',
              placeholder: 'Enter Phone number',
              validator: (value) {
                if (!GetUtils.isPhoneNumber(value!)) {
                  return 'Phone format error.';
                }

                if (value.isEmpty) {
                  return 'Phone is required.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            InputField(
              controller: controller.loginPasswordController,
              keyboardType: TextInputType.emailAddress,
              labelText: 'Password',
              placeholder: 'Enter Password',
              password: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required.';
                }

                if (value.length < 6 || value.length > 15) {
                  return 'Password should be 6~15 characters';
                }

                return null;
              },
            ),
            const SizedBox(height: 80),
            ElevatedButton(
                onPressed: () {
                  controller.login();
                },
                child: Text('Sign In')),
          ],
        ),
      ),
    );
  }
}
