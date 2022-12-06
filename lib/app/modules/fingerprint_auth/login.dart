import 'package:flutter/material.dart';
import 'package:presence/app/modules/fingerprint_auth/fingerprint_auth.dart';
import 'package:presence/app/modules/fingerprint_auth/home.dart';

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
    isFingerprintEnabled();
  }

  final FingerPrint _fingerprint = new FingerPrint();

  String fprint = '';
  void isFingerprintEnabled() async {
    fprint = await UserStorage.getFingerprint() ?? '';
    setState(() {});
  }

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
