import 'package:flutter/cupertino.dart';
import 'package:studify/screens/home/home_screen.dart';
import 'package:studify/screens/onboarding/onboarding_screen.dart';
import 'package:studify/screens/profile_setup/profile_setup_screen.dart';
import 'package:studify/screens/sign_in/sign_in_screen.dart';
import 'package:studify/screens/sign_up/components/register_screen.dart';
import 'package:studify/screens/sign_up/sign_up_screen.dart';
import 'package:studify/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  ProfileSetupScreen.routeName: (context) => const ProfileSetupScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};
