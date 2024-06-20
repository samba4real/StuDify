import 'package:flutter/material.dart';
import 'package:studify/screens/pages/home_nav.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomeBody());
  }
}
