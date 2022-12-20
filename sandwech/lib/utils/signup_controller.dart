import 'package:sandwech/utils/validation.dart';
import 'package:sandwech/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sandwech/utils/error_dialog.dart';
import 'package:sandwech/pages/homepage.dart';

class SignupModel {}

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<SignupModel> SignupModelObj = SignupModel().obs;

  Rx<bool> isShowPassword = false.obs;
  Rx<bool> isShowPasswordConfirm = false.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void PostSignUp(context) async {
    var dio = Dio();

    if (nameController.text != null &&
        nameController.text != '' &&
        surnameController.text != null &&
        nameController.text != '' &&
        emailController.text != null &&
        isValidEmail(emailController.text) &&
        passwordController.text != null &&
        isValidPassword(passwordController.text) &&
        confirmPasswordController.text == passwordController.text) {
      try {
        var response = await dio.post(postSignUpUrl,
            data: {
              'name': nameController.text,
              'surname': surnameController.text,
              'email': emailController.text,
              'password': passwordController.text
            },
            options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
                validateStatus: (status) {
                  return status! < 500;
                }));
        if (response.statusCode == 200) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(2)));
          return;
        } else {
          showDialogError(context, 'Impossibile registrarsi',
              'Controlla tutti i campi e poi riprova');
          return;
        }
      } catch (e) {
        showDialogError(context, 'Impossibile registrarsi',
            'Impossibile contattare il server. Controlla la connessione e riprova.');
        return;
      }
    } else {
      showDialogError(context, 'Impossibile registrarsi',
          'Compila tutti i campi correttamente');
      return;
    }
  }
}
