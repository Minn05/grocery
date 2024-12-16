import 'dart:convert';

import 'package:e_commerce/model/user.dart';
import 'package:e_commerce/service/local_service/local_auth_service.dart';
import 'package:e_commerce/service/remote_service/remote_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void onInit() async {
    await _localAuthService.init();
    super.onInit();
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signUp(
        email: email,
        password: password,
      );
      if (result.statusCode == 200) {
        String token = json.decode(result.body)['jwt'];
        var userResult = await RemoteAuthService().createProfile(
          fullName: fullName,
          token: token,
        );
        if (userResult.statusCode == 201) {
          user.value = userFroJson(userResult.body);
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);

          EasyLoading.showSuccess('Welcome to MyApp!');
          Navigator.of(Get.overlayContext!).pop();
        } else {
          EasyLoading.showError('Something wrong. Try again1!');
        }
      } else {
        EasyLoading.showError('Something wrong. Try again2!');
      }
    } catch (e) {
      EasyLoading.showError('Something wrong. Try again3!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signIn(
        email: email,
        password: password,
      );
      if (result.statusCode == 200) {
        String token = json.decode(result.body)['jwt'];
        var userResult = await RemoteAuthService().getProfile(
          token: token,
        );
        if (userResult.statusCode == 200) {
          user.value = userFroJson(userResult.body);
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);

          EasyLoading.showSuccess('Welcome to MyApp!');
          Navigator.of(Get.overlayContext!).pop();
        } else {
          EasyLoading.showError('Something wrong. Try again1!');
        }
      } else {
        EasyLoading.showError('Something wrong. Try again2!');
      }
    } catch (e) {
      EasyLoading.showError('Something wrong. Try again3!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> signOut() async {
    user.value = null;
    await _localAuthService.clear();
  }
}
