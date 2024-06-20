import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:studify/screens/profile_setup/components/profile_grid_selection_widget.dart';
import '../../../constants.dart';
import '../../../models/icon_selection_model.dart';
import '../../../size_config.dart';
import '../../../theme/texts_style.dart';
import 'circular_selection_buttons.dart';

class GoalSelection extends StatefulWidget {
  const GoalSelection({Key? key}) : super(key: key);

  @override
  State<GoalSelection> createState() => _GoalSelectionState();
}

class _GoalSelectionState extends State<GoalSelection> {
  @override
  Widget build(BuildContext context) {
    return ProfileGridSelectionWidget(
      subQuestion: 'What are',
      mainQuestion: 'Your Interests ?',
      gridWidget: Expanded(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: getProportionateScreenHeight(0.75),
            crossAxisCount: 2,
          ),
          itemCount: goalList.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                ZoomIn(
                  delay: Duration(milliseconds: index * 300),
                  duration: Constants.kOptionDuration,
                  child: Center(
                    child: CircularOptionButtons(
                      index: index,
                      onTap: () => setState(() => goalList
                          .elementAt(index)
                          .isSelected = !goalList.elementAt(index).isSelected),
                      isSelected: goalList.elementAt(index).isSelected,
                      child: Center(
                        child: Icon(
                          goalList.elementAt(index).icon,
                          size: getProportionateScreenHeight(40),
                          color: const Color(0xFF6F35A5),
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
                    goalList[index].item,
                    style: AppTextStyle.subNBodyBold.copyWith(
                      fontSize: getProportionateScreenHeight(16),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
