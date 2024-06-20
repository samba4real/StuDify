import 'package:flutter/material.dart';

import 'package:studify/screens/onboarding/components/body.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String routeName = '/onBoarding';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Body());
  }
}
