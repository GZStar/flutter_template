import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/input_field.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('login'.tr),
            centerTitle: true,
          ),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: _buildForms(context),
          ),
        ));
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
                if (value!.isEmpty) {
                  return 'Phone is required.';
                }

                if (!GetUtils.isPhoneNumber(value)) {
                  return 'Phone format error.';
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
                  FocusScope.of(context).unfocus();
                  controller.login();
                },
                child: Text('Sign In')),
          ],
        ),
      ),
    );
  }
}
