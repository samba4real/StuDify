import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studify/screens/sign_up/components/register_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../theme/texts_style.dart';

class AuthButtons extends StatelessWidget {
  final String text;
  final IconData icon;

  const AuthButtons({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(18)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Constants.kSecondaryLightColor.withOpacity(0.4)),
          child: Row(
            children: [
              FaIcon(
                icon,
                color: const Color(0xFF6F35A5),
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.subNBodyBold
                      .copyWith(fontSize: getProportionateScreenHeight(18)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
