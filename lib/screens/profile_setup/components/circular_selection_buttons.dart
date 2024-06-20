import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:studify/constants.dart';
import '../../../size_config.dart';

class CircularOptionButtons extends StatefulWidget {
  final bool isSelected;
  final int index;
  final VoidCallback onTap;
  final Widget child;
  const CircularOptionButtons({
    Key? key,
    required this.index,
    required this.onTap,
    required this.isSelected,
    required this.child,
  }) : super(key: key);

  @override
  State<CircularOptionButtons> createState() => _CircularOptionButtonsState();
}

class _CircularOptionButtonsState extends State<CircularOptionButtons>
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

    return Container(
      margin: EdgeInsets.only(
          top: widget.index % 2 != 0 ? getProportionateScreenHeight(30) : 0),
      child: Stack(alignment: Alignment.topRight, children: [
        Transform.scale(
          scale: scale,
          child: GestureDetector(
            onTapDown: onTapDown,
            onTapUp: onTapUp,
            onTapCancel: () {
              controller.reverse();
            },
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: getProportionateScreenHeight(130),
                width: getProportionateScreenHeight(130),
                decoration: BoxDecoration(
                  border: widget.isSelected
                      ? Border.all(width: 2, color: Constants.kPrimaryColor)
                      : Border.all(
                          width: 0.8, color: Constants.kSecondaryLightColor),
                  shape: BoxShape.circle,
                ),
                child: widget.child),
          ),
        ),
        widget.isSelected
            ? ZoomIn(
                child: Container(
                  margin: EdgeInsets.all(getProportionateScreenHeight(6)),
                  height: getProportionateScreenHeight(30),
                  width: getProportionateScreenHeight(30),
                  decoration: const BoxDecoration(
                    color:  Color(0xFF6F35A5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: getProportionateScreenHeight(16),
                  ),
                ),
              )
            : const SizedBox()
      ]),
    );
  }
}
