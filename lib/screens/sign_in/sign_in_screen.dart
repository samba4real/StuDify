import 'package:flutter/material.dart';
import 'package:studify/screens/sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/signInScreen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Body());
  }
}
