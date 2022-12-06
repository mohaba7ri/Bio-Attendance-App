import 'package:local_auth/local_auth.dart';

class FingerPrint {
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
}
