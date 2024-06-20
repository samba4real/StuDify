import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/screens/home/home_screen.dart';
import 'package:studify/screens/sign_in/sign_in_screen.dart';
import 'package:studify/screens/splash/splash_screen.dart';
import 'package:studify/routes.dart';
import 'package:studify/size_config.dart';
import 'package:studify/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    const StuDify(),
  );
}

class StuDify extends StatefulWidget {
  const StuDify({
    super.key,
  });

  @override
  State<StuDify> createState() => _StuDifyState();
}

class _StuDifyState extends State<StuDify> {
  bool _isSignedIn = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    initApp();
    // getUserLoggedInStatus();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initApp();
    });
  }

  Future<void> initApp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getBool(HelperFunctions.userLoggedInKey);
    getUserLoggedInStatus();
  }

  Future<void> getUserLoggedInStatus() async {
    bool? value = await HelperFunctions.getUserLoggedInStatus();
    if (value != null) {
      setState(() {
        _isSignedIn = value;
      });
    }
    // print(value);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StuDify',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
      home: _isSignedIn ? const HomeScreen() : const SignInScreen(),
    );
  }
}

