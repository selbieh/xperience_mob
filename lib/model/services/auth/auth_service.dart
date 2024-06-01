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
  bool get isLogged => SharedPref.getBool(SharedPrefKeys.isUserLoggedIn) ?? false == true;

  ///============================================================================== Save User
  Future<bool> saveUser(UserModel user) async {
    try {
      await Future.wait([
        SharedPref.setString(SharedPrefKeys.user, json.encode(user.toJson())),
        SharedPref.setString(SharedPrefKeys.tokenAccess, "=== USER_TOKEN ==="),
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
      Map<String, dynamic> userMap = json.decode(SharedPref.getString(SharedPrefKeys.user)!);
      _userModel = UserModel.fromJson(userMap);
      Logger.printObject(_userModel, title: "loadUser 👤👤");

      notifyListeners();
      return true;
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
  Future<Either<AppFailure, dynamic>> loginRegister({required Map<String, dynamic> body}) async {
    try {
      final res = await HttpService.request(
        endPoint: EndPoints.login,
        requestType: RequestType.post,
        header: Headers.guestHeader,
        body: body,
      );
      if (res.right != null) {
        await saveUser(UserModel.fromJson(res.right));
        return Either(right: true);
      } else {
        return Either(left: res.left);
      }
    } catch (error) {
      return Either(left: AppFailure(message: error.toString()));
    }
  }

  // ///============================================================================== SignUp
  // Future<Either<AppFailure, dynamic>> signUp(
  //   BuildContext context, {
  //   required Map<String, dynamic> body,
  // }) async {
  //   try {
  //     final res = await HttpService.request(
  //       endPoint: EndPoints.register,
  //       requestType: RequestType.post,
  //       header: Headers.guestHeader,
  //       body: body,
  //     );
  //     if (res.right != null) {
  //       return Either(right: true);
  //     } else {
  //       return Either(left: res.left);
  //     }
  //   } catch (error) {
  //     return Either(left: AppFailure(message: error.toString()));
  //   }
  // }

  // ///============================================================================== Update Profile
  // Future<Either<AppFailure, dynamic>> updateProfile(
  //   BuildContext context, {
  //   required Map<String, dynamic> body,
  // }) async {
  //   try {
  //     final res = await HttpService.request(
  //       endPoint: EndPoints.test,
  //       requestType: RequestType.post,
  //       header: Headers.userHeader,
  //       body: body,
  //     );
  //     if (res.right != null) {
  //       UserModel? tempUser = UserModel.fromJson(res.right["data"]);
  //       tempUser.token = _userModel?.token;
  //       await saveUser(tempUser);
  //       return Either(right: true);
  //     } else {
  //       return Either(left: res.left);
  //     }
  //   } catch (error) {
  //     return Either(left: AppFailure(message: error.toString()));
  //   }
  // }

  // ///============================================================================== Change Password
  // Future<Either<AppFailure, dynamic>> changePassword(
  //   BuildContext context, {
  //   required Map<String, dynamic> body,
  // }) async {
  //   try {
  //     final res = await HttpService.request(
  //       endPoint: EndPoints.test,
  //       requestType: RequestType.post,
  //       header: Headers.guestHeader,
  //       body: body,
  //     );
  //     if (res.right != null) {
  //       return Either(right: true);
  //     } else {
  //       return Either(left: res.left);
  //     }
  //   } catch (error) {
  //     return Either(left: AppFailure(message: error.toString()));
  //   }
  // }

  ///============================================================================================================
  ///============================================================================================================
}
