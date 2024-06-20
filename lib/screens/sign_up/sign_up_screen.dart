import 'package:flutter/material.dart';
import 'package:studify/screens/sign_up/components/register_body.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signUpScreen';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: RegisterBody());
  }
}
