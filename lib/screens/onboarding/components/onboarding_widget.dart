import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import '../../../theme/texts_style.dart';

class OnboardingWidget extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subTitle;
  const OnboardingWidget(
      {Key? key,
      required this.imageAsset,
      required this.title,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ZoomIn(
            child: Image.asset(
              imageAsset,
              width: size.width * 0.8,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 500),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 400),
                  child: Text(
                    subTitle,
                    style: AppTextStyle.subNBodyReg.copyWith(
                        // color: Pallete.lightGrayColor,
                        fontSize: getProportionateScreenHeight(18)),
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 500),
                child: Text(
                  title,
                  style: AppTextStyle.titleHeading.copyWith(
                    fontSize: getProportionateScreenHeight(35),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
