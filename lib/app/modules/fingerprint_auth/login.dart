import 'package:Biometric/app/modules/fingerprint_auth/home.dart';
import 'package:flutter/material.dart';

import '../../controllers/biometric_controller.dart';
import 'fingerprint_auth.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogIN(),
    );
  }
}

class LogIN extends StatefulWidget {
  LogIN({
    Key? key,
  }) : super(key: key);

  @override
  State<LogIN> createState() => _LogINState();
}

class _LogINState extends State<LogIN> {
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  final FingerPrint _fingerprint = new FingerPrint();

  String fprint = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FingerPrint'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text('Log In')),
            ),
            if (fprint.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      _fingerprintLogin();
                    },
                    child: Text('finger print enabled')),
              ),
          ]),
    );
  }

  void _fingerprintLogin() async {
    bool isFingerprintEnabled = await _fingerprint.isFingerPrintEnabled();
    if (isFingerprintEnabled) {
      bool isAuth = await _fingerprint.isAuth('login using finger print');
      if (isAuth) {
        print('wlecome');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    }
  }
}
