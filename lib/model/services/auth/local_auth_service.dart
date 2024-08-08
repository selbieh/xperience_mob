import 'package:local_auth/local_auth.dart';
import 'package:xperience/model/config/logger.dart';

class LocalAuthService {
  final _localAuth = LocalAuthentication();

// Check if device has any Security credentials (pin, pattern, passcode, biometrics)
  Future<bool> isDeviceSupported() async {
    try {
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      Logger.log("isDeviceSupported: $isDeviceSupported");
      return isDeviceSupported;
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }

// Check if can check device biometrics
  Future<bool> isCanCheckBiometrics() async {
    try {
      final bool isCanAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      Logger.log("isCanCheckBiometrics: $isCanAuthenticateWithBiometrics");
      return isCanAuthenticateWithBiometrics;
    } catch (error) {
      Logger.printt(error, isError: true);
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      final biometricsList = await _localAuth.getAvailableBiometrics();
      Logger.log("biometricsList: $biometricsList");
      return biometricsList;
    } catch (error) {
      Logger.printt(error, isError: true);
      return [];
    }
  }

  Future<bool> authenticate() async {
    try {
      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: "Authenticate to access Xperience",
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      if (isAuthenticated) {
        Logger.log("User successfully authenticated");
        return true;
      } else {
        Logger.log("User not authenticated");
        return false;
      }
    } catch (error) {
      Logger.printt(error, isError: true);
      return true;
    }
  }

  // Future<bool> authenticate() async {
  //   try {
  //     final bool isHasCredentials = await isHasSecurityCredentials();
  //     if (isHasCredentials) {
  //       final isAuthenticated = await _localAuth.authenticate(
  //         localizedReason: "Scan fingerprint to authenticate",
  //         options: const AuthenticationOptions(
  //           useErrorDialogs: true,
  //           stickyAuth: true,
  //         ),
  //       );
  //       if (isAuthenticated) {
  //         Logger.log("User successfully authenticated");
  //         return true;
  //       } else {
  //         Logger.log("User not authenticated");
  //         return false;
  //       }
  //     } else {
  //       return true;
  //     }
  //   } catch (error) {
  //     Logger.printt(error, isError: true);
  //     return true;
  //   }
  // }
}
