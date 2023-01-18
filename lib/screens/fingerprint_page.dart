import 'package:flutter_firebase_vote/api/local_auth_api.dart';
import 'package:flutter_firebase_vote/main.dart';
import 'package:flutter_firebase_vote/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class FingerprintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        //appBar: AppBar(
        //  title: Text("heading"),
        //  centerTitle: true,
        //),
        body: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("     AADHAR                 VERIFICATION",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.blue,
                        shadows: [
                          Shadow(
                              color: Colors.blueAccent,
                              offset: Offset(2, 1),
                              blurRadius: 10)
                        ])),
                Text("Scan your finger using Phone's Biometric Sensor"),
                SizedBox(height: 40),
                Image.asset('assets/images/fingerprint_image2.gif'),
                SizedBox(height: 40),
                buildAvailability(context),
                SizedBox(height: 24),
                buildAuthenticate(context),
              ],
            ),
          ),
        ),
      );

  Widget buildAvailability(BuildContext context) => buildButton(
        text: 'Check Availability',
        icon: Icons.event_available,
        onClicked: () async {
          print("working");
          final isAvailable = await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();
          print("yessssssssss");

          final hasFingerprint = biometrics.contains(BiometricType.fingerprint);

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Availability'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildText('Biometrics', isAvailable),
                  buildText('Fingerprint', hasFingerprint),
                ],
              ),
            ),
          );
        },
      );

  Widget buildText(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          print("1");
          final isAuthenticated = await LocalAuthApi.authenticate();
          print("3");
          if (isAuthenticated) {
            print("4");
            Navigator.pushReplacementNamed(context, '/home');
            //Navigator.of(context).pushReplacement(
            //  MaterialPageRoute(
            //      builder: (context) => HomeScreeen()), //change here
            //);
          }
        },
      );

  Widget buildButton({
    @required String text,
    @required IconData icon,
    @required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
