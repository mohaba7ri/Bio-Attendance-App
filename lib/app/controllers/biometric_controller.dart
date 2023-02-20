import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class BiometricController extends GetxController {
  bool isEnabled = false;

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  //this function to check whether your phone enable fingerprint or not
  Future<bool> isFingerPrintEnabled() async {
    bool fingerPrintEnabled = await _localAuthentication.canCheckBiometrics;

    return fingerPrintEnabled;
  }

//this function  for authentication an ensure the fingerprint the same in your phone
  Future<bool> isAuth(String reason) async {
    bool auth = await _localAuthentication.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(biometricOnly: true));
    return auth;
  }

  void loadUser() async {
    final fPrint = await UserStorage.getFingerprint() ?? '';
    isEnabled = fPrint.isNotEmpty;
    update();
  }

  void enabledFingerPrint(value) async {
    update();
    if (value) {
      //ensure that fingerprint is enabled
      bool isFingerprintEnabled = await isFingerPrintEnabled();
      if (isFingerprintEnabled) {
        await UserStorage.setFingerprint();
      }
    } else {
      await UserStorage._storage.delete(key: 'fingerprint');
    }
    isEnabled = value;
    update();
  }

  void fingerprintLogin() async {
    bool isFingerprintEnabled = await isFingerPrintEnabled();
    if (isFingerprintEnabled) {
      bool _isEnabled = await isAuth('login using finger print');
      if (_isEnabled) {}
    }
  }
}

class UserStorage {
  static final _storage = new FlutterSecureStorage();
  static const _fingerPrint = 'fingerprint';
  static Future setFingerprint() async =>
      await _storage.write(key: _fingerPrint, value: 'checked');

  static Future<String?> getFingerprint() async =>
      await _storage.read(key: _fingerPrint);
}
