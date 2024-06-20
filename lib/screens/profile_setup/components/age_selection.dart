import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:studify/screens/profile_setup/components/circular_selection_buttons.dart';
import 'package:studify/screens/profile_setup/components/profile_grid_selection_widget.dart';
import 'package:studify/theme/texts_style.dart';
import '../../../models/text_selection_model.dart';

class AgeSelection extends StatefulWidget {
  const AgeSelection({Key? key}) : super(key: key);
  @override
  State<AgeSelection> createState() => _AgeSelectionState();
}

class _AgeSelectionState extends State<AgeSelection> {
  @override
  Widget build(BuildContext context) {
    return ProfileGridSelectionWidget(
        subQuestion: 'What\'s',
        mainQuestion: 'Your Age?',
        gridWidget: Expanded(
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: ageList.length,
              itemBuilder: ((context, index) {
                return ZoomIn(
                  delay: Duration(milliseconds: index * 300),
                  duration: const Duration(milliseconds: 400),
                  child: Center(
                    child: CircularOptionButtons(
                      index: index,
                      onTap: () {
                        setState(() {});
                        for (var option in ageList) {
                          if (option == ageList[index]) {
                            option.isSelected = true;
                          } else {
                            option.isSelected = false;
                          }
                        }
                      },
                      isSelected: ageList.elementAt(index).isSelected,
                      child: Center(
                          child: Text(
                        ageList.elementAt(index).ageRange,
                        style: AppTextStyle.subNBodyBold.copyWith(
                          color: const Color(0xFF6F35A5),
                        ),
                      )),
                    ),
                  ),
                );
              })),
        ));
  }
}
