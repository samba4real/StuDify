import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/screens/home/home_screen.dart';
import 'package:studify/screens/sign_in/sign_in_screen.dart';
import 'package:studify/theme/texts_style.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../onboarding/onboarding_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future getData() async {
    bool _isSignedIn = false;
    Future.delayed(const Duration(seconds: 3), () async {
      bool? value = await HelperFunctions.getUserLoggedInStatus();

      if (value != null) {
        if (value == true) {
          Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
        } else {
          // Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
          Navigator.of(context).popAndPushNamed(OnBoardingScreen.routeName);
        }
      } else {
        // Navigator.of(context).popAndPushNamed(OnBoardingScreen.routeName);
        Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              Constants.logo,
              height: getProportionateScreenHeight(50),
              color: const Color(0xFF6F35A5),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              "WELCOME TO ",
              style: AppTextStyle.titleHeading.copyWith(
                color: const Color(0xFF6F35A5),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              "StuDify.",
              style: AppTextStyle.titleHeading.copyWith(
                color: const Color(0xFF6F35A5),
                fontSize: 50,
              ),
            ),
          ],
        ),
        SizedBox(
          height: getProportionateScreenHeight(50),
        ),
        Lottie.asset(
          Constants.splashScreenAsset,
          height: getProportionateScreenHeight(300),
          repeat: false,
        ),
      ],
    );
  }
}

