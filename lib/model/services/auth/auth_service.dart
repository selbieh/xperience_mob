import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:xperience/model/config/logger.dart';
import 'package:xperience/model/models/user_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';
import 'package:xperience/model/services/api/end_points.dart';
import 'package:xperience/model/services/api/headers.dart';
import 'package:xperience/model/services/api/http_service.dart';
import 'package:xperience/model/services/shared_preference.dart';

class AuthService extends ChangeNotifier {
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  // bool get isLogged => SharedPref.getBool(SharedPrefKeys.isUserLoggedIn) ?? false == true;
  bool get isLogged => userModel != null;

  ///============================================================================== Save User
  Future<bool> saveUser(UserModel user) async {
    try {
      await Future.wait([
        SharedPref.setString(SharedPrefKeys.user, json.encode(user.toJson())),
        SharedPref.setString(SharedPrefKeys.tokenAccess, user.access ?? "=== NOT_FOUND_TOKEN ==="),
        SharedPref.setBool(SharedPrefKeys.isUserLoggedIn, true),
      ]);
      _userModel = user;
      Logger.printObject(user, title: "saveUser 👤👤");

      notifyListeners();
      return true;
    } catch (error) {
      Logger.printt("saveUser error ---> ${error.toString()}");
      return false;
    }
  }

  ///============================================================================== Load User
  Future<bool> loadUser() async {
    try {
      final userString = SharedPref.getString(SharedPrefKeys.user);
      if (userString != null) {
        Map<String, dynamic> userMap = json.decode(userString);
        _userModel = UserModel.fromJson(userMap);
        Logger.printObject(_userModel, title: "loadUser 👤👤");
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Logger.printt("loadUser error ---> ${error.toString()}");
      await SharedPref.clear();
      return false;
    }
  }

  ///============================================================================== Remove User
  Future<bool> removeUser() async {
    try {
      await Future.wait([
        SharedPref.remove(SharedPrefKeys.user),
        SharedPref.remove(SharedPrefKeys.tokenAccess),
        SharedPref.remove(SharedPrefKeys.isUserLoggedIn),
      ]);
      _userModel = null;
      notifyListeners();
      return true;
    } catch (error) {
      Logger.printt("removeUser error ---> ${error.toString()}");
      return false;
    }
  }

  ///============================================================================== SignOut
  Future<bool> signOut() async {
    try {
      await removeUser();
      return true;
    } catch (error) {
      Logger.printt("signOut error ---> ${error.toString()}");
      return false;
    }
  }

  ///============================================================================== Login / Register
  Future<Either<AppFailure, bool>> phoneLoginRegister({required Map<String, dynamic> body}) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.loginRegister,
        requestType: RequestType.post,
        header: Headers.guestHeader,
        body: body,
      );
      if (res.right != null) {
        return Either(right: true);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  ///============================================================================== Phone verify
  Future<Either<AppFailure, UserModel>> phoneVerify({required Map<String, dynamic> body}) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.verifyPhone,
        requestType: RequestType.post,
        header: Headers.guestHeader,
        body: body,
      );
      if (res.right != null) {
        final resUser = UserModel.fromJson(res.right);
        await saveUser(resUser);
        return Either(right: resUser);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  // ///============================================================================== Update Profile
  Future<Either<AppFailure, UserModel>> updateUserProfile({
    required Map<String, dynamic> body,
  }) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.profile,
        requestType: RequestType.patch,
        header: Headers.userHeader,
        body: body,
      );
      if (res.right != null) {
        final resUserInfo = UserInfo.fromJson(res.right);
        UserModel? tempUserModel = userModel;

        tempUserModel?.user?.name = resUserInfo.name;
        tempUserModel?.user?.email = resUserInfo.email;
        if (tempUserModel != null) {
          await saveUser(tempUserModel);
        }
        return Either(right: tempUserModel);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  ///============================================================================================================
  ///============================================================================================================
}
