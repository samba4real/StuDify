import 'package:flutter/material.dart';
import 'package:studify/screens/profile_setup/components/body.dart';

class ProfileSetupScreen extends StatefulWidget {
  static const routeName = '/profileSetup';
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
