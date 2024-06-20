import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final PageController controller;
  const PageIndicator({Key? key, required this.count, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      effect: const WormEffect(
          radius: 0,
          dotHeight: 7,
          dotWidth: 30,
          dotColor: Constants.kSecondaryLightColor,
          activeDotColor: Color(0xFF6F35A5),
          spacing: 0),
      controller: controller,
      count: count,
    );
  }
}
