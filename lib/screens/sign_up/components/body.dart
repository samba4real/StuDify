import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studify/constants.dart';
import 'package:studify/screens/sign_up/components/auth_buttons.dart';
import 'package:studify/size_config.dart';
import 'package:studify/theme/texts_style.dart';

import '../../sign_in/sign_in_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: Constants.kPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeInDown(
                from: 30,
                duration: const Duration(milliseconds: 800),
                child: Row(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(100),
                    ),
                    Image.asset(
                      Constants.logo,
                      height: getProportionateScreenHeight(50),
                      color: const Color(0xFF6F35A5),
                    ),
                    Text(
                      'StuDify',
                      style: AppTextStyle.titleHeading
                          .copyWith(fontSize: getProportionateScreenHeight(20)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              FadeInDown(
                delay: const Duration(milliseconds: 500),
                from: 30,
                duration: const Duration(milliseconds: 800),
                child: Text('Create an account with us',
                    style: AppTextStyle.titleHeading
                        .copyWith(fontSize: getProportionateScreenHeight(50))),
              ),
              SizedBox(
                height: getProportionateScreenHeight(50),
              ),
              // const Spacer(),
              Column(
                children: [
                  const AuthButtons(
                      text: 'Sign up with Google',
                      icon: FontAwesomeIcons.google),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  const AuthButtons(
                      text: 'Sign up with Facabook',
                      icon: FontAwesomeIcons.facebook),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  const AuthButtons(
                    text: 'Sign up with Email',
                    icon: FontAwesomeIcons.solidEnvelope,
                  )
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: AppTextStyle.subNBodyMeduim.copyWith(
                        fontSize: getProportionateScreenHeight(16),
                        color: Colors.black38),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(5),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignInScreen.routeName);
                    },
                    child: Text(
                      'Sign In',
                      style: AppTextStyle.subNBodyBold.copyWith(
                        fontSize: getProportionateScreenHeight(16),
                        color: Constants.kPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
