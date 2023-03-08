import 'package:Biometric/app/controllers/presence_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_pages.dart';

class BiometricController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadUser();
    isFingerPrintEnabled();
  }

  final presenceController = Get.find<PresenceController>();

  final SharedPreferences sharedPreferences;
  BiometricController({required this.sharedPreferences});

  bool isEnabled = false;

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> isFingerPrintEnabled() async {
    bool fingerPrintEnabled = await _localAuthentication.canCheckBiometrics;
    return fingerPrintEnabled;
  }

  Future<bool> isAuth(String reason) async {
    bool auth = false;
    try {
      auth = await _localAuthentication.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: false,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }
    return auth;
  }

  void loadUser() async {
    final fPrint = await UserStorage.getFingerprint() ?? '';
    isEnabled = fPrint.isNotEmpty;
    update();
  }

  void enabledFingerPrint(String userId, value) async {
    update();
    if (value) {
      bool isFingerprintEnabled = await isFingerPrintEnabled();
      if (isFingerprintEnabled) {
        await UserStorage.setFingerprint();
        sharedPreferences.setString('userId', userId);
        sharedPreferences.setString(userId, value.toString());
      }
    } else {
      await UserStorage._storage.delete(key: 'fingerprint');
    }
    isEnabled = value;
    update();
  }

  String fprint = '';
  void isFingerprintEnabled() async {
    fprint = await UserStorage.getFingerprint() ?? '';
    update();
  }

  void fingerprintLogin() async {
    bool isFingerprintEnabled = await isFingerPrintEnabled();
    if (isFingerprintEnabled) {
      bool _isEnabled = await isAuth('login using finger print');
      if (_isEnabled) {
        Get.offAllNamed(Routes.HOME);
      }
    }
  }

  void bioMetricPresence() async {
    bool isEnabled = await isFingerPrintEnabled();
    if (isEnabled) {
      bool _isEnabled = await isAuth('Register presence using Biometrics');
      if (_isEnabled) {
        presenceController
          ..checkTime()
          ..presence();
      }
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
