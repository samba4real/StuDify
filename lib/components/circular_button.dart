import 'package:flutter/material.dart';
import '../constants.dart';
import '../size_config.dart';
import '../theme/texts_style.dart';

class CircularButton extends StatefulWidget {
  final VoidCallback onTap;

  final String text;
  const CircularButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double scale;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Constants.kDuration,
        lowerBound: 0.0,
        upperBound: 0.2)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - controller.value;

    void onTapDown(TapDownDetails details) {
      controller.forward();
    }

    void onTapUp(TapUpDetails details) {
      controller.reverse();
      widget.onTap();
    }

    return Transform.scale(
      scale: scale,
      child: GestureDetector(
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        child: Container(
          alignment: Alignment.center,
          width: getProportionateScreenHeight(100),
          height: getProportionateScreenHeight(100),
          padding: EdgeInsets.all(getProportionateScreenHeight(10)),
          decoration: const BoxDecoration(
              color: Color(0xFF6F35A5), shape: BoxShape.circle),
          child: Text(
            widget.text,
            style: AppTextStyle.titleHeading.copyWith(
                fontSize: getProportionateScreenHeight(18),
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
