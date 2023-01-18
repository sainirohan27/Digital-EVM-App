import 'package:flutter/material.dart';
import 'screens/form_screen.dart';
import 'package:flutter_firebase_vote/screens/result_screen.dart';
import 'package:provider/provider.dart';
import 'screens/launch_screen.dart';
import 'screens/fingerprint_page.dart';
import 'screens/home_screen.dart';
import 'constants.dart';
import 'package:flutter_firebase_vote/state/vote.dart';
import 'package:flutter_firebase_vote/state/authentication.dart';
import 'package:flutter_firebase_vote/utilities.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(VoteApp());
}
//void main() => runApp(VoteApp());

class VoteApp extends StatelessWidget {
  static const String title = 'Local Auth';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => VoteState()),
          ChangeNotifierProvider(create: (_) => AuthenticationState()),
        ],
        child:
            Consumer<AuthenticationState>(builder: (context, authState, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => Scaffold(
                    body: LaunchScreen(),
                  ),
              '/form': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Voter ID Details for Authentication'),
                      actions: <Widget>[
                        getActions(context, authState),
                      ],
                    ),
                    body: FormScreen(),
                  ),
              '/fingerprint': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Biometric Authentication'),
                      actions: <Widget>[
                        getActions(context, authState),
                      ],
                    ),
                    //theme: ThemeData(primarySwatch: Colors.purple),
                    body: FingerprintPage(),
                  ),
              '/home': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(kAppName),
                      actions: <Widget>[
                        getActions(context, authState),
                      ],
                    ),
                    body: HomeScreeen(),
                  ),
              '/result': (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('Result'),
                      leading: IconButton(
                        icon: Icon(Icons.home),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                      actions: <Widget>[
                        getActions(context, authState),
                      ],
                    ),
                    body: ResultScreen(),
                  )
            },
          );
        }));
  }

  PopupMenuButton getActions(
      BuildContext context, AuthenticationState authState) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Logout'),
        )
      ],
      onSelected: (value) {
        if (value == 1) {
          // logout
          authState.logout();
          gotoLoginScreen(context, authState);
        }
      },
    );
  }
}
