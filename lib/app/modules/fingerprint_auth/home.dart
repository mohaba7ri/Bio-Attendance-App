import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:presence/app/modules/fingerprint_auth/login.dart';

import 'fingerprint_auth.dart';

class Home extends StatefulWidget {
  // const Home({this.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser();
  }

  final FingerPrint _fingerPrint = new FingerPrint();

  bool? _isSwitchedChecked = false;
  void loadUser() async {
    final fPrint = await UserStorage.getFingerprint() ?? '';
    _isSwitchedChecked = fPrint.isNotEmpty;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('fingerprint'),
      ),
      body: Column(
        children: [
          Center(
            child: Row(
              children: [
                Text('Enable fingerPrint'),
                SizedBox(
                  width: 5,
                ),
                Switch(
                    value: _isSwitchedChecked!,
                    onChanged: (value) {
                      _enabledFingerPrint(value);
                    })
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => LogIN()));
              },
              child: Text('Log Out')),
        ],
      ),
    );
  }

  void _enabledFingerPrint(value) async {
    if (value) {
      //ensure that fingerprint is enabled
      bool isFingerprintEnabled = await _fingerPrint.isFingerPrintEnabled();
      if (isFingerprintEnabled) {
        await UserStorage.setFingerprint();
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('FingerPrint Enabled')));
      }
    } else {
      await UserStorage._storage.delete(key: 'fingerprint');
    }
    setState(() {
      _isSwitchedChecked = value;
    });
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
