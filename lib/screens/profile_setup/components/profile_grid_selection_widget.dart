import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import '../../../theme/texts_style.dart';

class ProfileGridSelectionWidget extends StatelessWidget {
  final String subQuestion;
  final String mainQuestion;
  final Widget gridWidget;
  const ProfileGridSelectionWidget({
    Key? key,
    required this.subQuestion,
    required this.mainQuestion,
    required this.gridWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FadeInDown(
          from: 30,
          duration: const Duration(milliseconds: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subQuestion,
                style: AppTextStyle.subNBodyReg
                    .copyWith(color: Colors.grey[700], fontSize: 20),
              ),
              Text(
                mainQuestion,
                style: AppTextStyle.titleHeading
                    .copyWith(fontSize: 40, color: const Color(0xFF6F35A5)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(50),
        ),
        gridWidget
      ]),
    );
  }
}
