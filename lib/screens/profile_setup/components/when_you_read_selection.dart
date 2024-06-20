import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:studify/models/icon_selection_model.dart';
import 'package:studify/screens/profile_setup/components/profile_grid_selection_widget.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../theme/texts_style.dart';
import 'circular_selection_buttons.dart';

class WhenYouReadSelection extends StatefulWidget {
  const WhenYouReadSelection({Key? key}) : super(key: key);

  @override
  State<WhenYouReadSelection> createState() => _WhenYouReadSelectionState();
}

class _WhenYouReadSelectionState extends State<WhenYouReadSelection> {
  @override
  Widget build(BuildContext context) {
    return ProfileGridSelectionWidget(
        subQuestion: "Select",
        mainQuestion: 'Your School.',
        gridWidget: Expanded(
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: getProportionateScreenHeight(0.75),
                crossAxisCount: 2,
              ),
              itemCount: whenToReadList.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    ZoomIn(
                      delay: Duration(milliseconds: index * 300),
                      duration: Constants.kOptionDuration,
                      child: Center(
                        child: CircularOptionButtons(
                          index: index,
                          onTap: () {
                            setState(() {});
                            for (var option in whenToReadList) {
                              if (option == whenToReadList[index]) {
                                option.isSelected = true;
                              } else {
                                option.isSelected = false;
                              }
                            }
                          },
                          isSelected:
                              whenToReadList.elementAt(index).isSelected,
                          child: Center(
                            child: Image.asset(
                              whenToReadList.elementAt(index).image!,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    FadeIn(
                      delay: Duration(milliseconds: index * 300),
                      duration: Constants.kOptionDuration,
                      child: Text(
                        whenToReadList[index].item,
                        style: AppTextStyle.subNBodyBold.copyWith(
                          fontSize: getProportionateScreenHeight(16),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                );
              })),
        ));
  }
}
