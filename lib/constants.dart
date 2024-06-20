import 'package:flutter/cupertino.dart';
import 'package:studify/size_config.dart';

class Constants {
  static const onBoardingSlideOne = 'assets/images/signup copy.png';
  static const onBoardingSlideTwo = 'assets/images/login copy.png';
  static const onBoardingSlideThree = 'assets/images/chat copy.png';
  // static const splashScreenAsset = 'assets/anim/splash_screen.json';
  static const splashScreenAsset = 'assets/anim/animation_llc7vnvw.json';
  static const loadingAnimationAsset = 'assets/anim/loading_anim.json';
  static const successAnimationAsset = 'assets/anim/success_anim.json';
  static const errorAnimationAsset = 'assets/anim/error_anim.json';
  static const warningAnimationAsset = 'assets/anim/warning_anim.json';
  static const logo = 'assets/images/logo.png';
  static const uccLogo = "assets/images/ucc-logo.png";
  static const knustLogo =
      "assets/images/KNUST_logo-Vector_0-removebg-preview.png";
  static const gctuLogo = "assets/images/cropped-logo_favicon.png";
  static const ugLogo =
      "assets/images/4445-universite-ghana-removebg-preview.png";
  static final kPagePadding = EdgeInsets.symmetric(
      horizontal: getProportionateScreenWidth(25),
      vertical: getProportionateScreenHeight(20));
  static const kDuration = Duration(milliseconds: 250);
  static const kOptionDuration = Duration(milliseconds: 400);
  // static const kPrimaryColor = Color(0xFF111111);
  static const kPrimaryColor = Color(0xFF817DC0);
  static const kPrimaryLightColor = Color(0xFFFFFFFF);
  static const kSecondaryLightColor = Color.fromARGB(255, 205, 205, 205);
  static const kWarningColor = Color.fromARGB(255, 255, 247, 176);
  static const kSuccessColor = Color.fromARGB(255, 181, 255, 184);
  static const kErrorColor = Color.fromARGB(255, 255, 215, 212);
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp nameValidatorRegExp = RegExp(
      r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)");
  static final RegExp passwordValidatorRegExp =
      RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");
  static const String kEmailNullError = "Please Enter your email";
  static const String kNameNullError = "Please Enter your name";
  static const String kInvalidEmailError = "Please Enter a Valid Email";
  static const String kInvalidNameError =
      "Please Enter a valid firstname and lastname";
  static const String kPassNullError =
      "Minimum eight characters, at least one letter, one number and one special character";
  static const String kShortPassError =
      "Password should be at least 8 characters";
  static const String kMatchPassError = "Passwords don't match";
  // static const String kNamelNullError = "Please Enter your name";
  static const String kPhoneNumberNullError = "Please Enter your phone number";
  static const String kAddressNullError = "Please Enter your address";
}
