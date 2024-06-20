import 'package:flutter/material.dart';
import 'package:studify/screens/splash/components/body.dart';
import 'package:studify/size_config.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(body: Body());
  }
}
