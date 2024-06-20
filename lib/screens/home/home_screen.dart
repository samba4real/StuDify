import 'package:flutter/material.dart';
import 'package:studify/screens/home/components/home_body.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomePage());
  }
}
