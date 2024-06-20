import 'package:flutter/material.dart';
import 'package:studify/helper/snack_bar_logic.dart';
import 'package:studify/screens/profile_setup/components/goal_selection.dart';
import 'package:studify/screens/profile_setup/components/when_you_read_selection.dart';
import 'package:studify/screens/sign_in/sign_in_screen.dart';
import '../../../size_config.dart';
import '../../../theme/texts_style.dart';
import 'age_selection.dart';
import 'gender_selection.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Widget> profileScreens = const [
    GenderSelection(),
    AgeSelection(),
    WhenYouReadSelection(),
    GoalSelection(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: IndexedStack(
                key: ValueKey<int>(currentIndex), //using StateProvider<int>
                index: currentIndex,
                children: profileScreens,
              ),
            ),
          ),
          Container(
            height: getProportionateScreenHeight(150),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${currentIndex + 1} of  ${profileScreens.length}',
                  style: AppTextStyle.subNBodyMeduim.copyWith(
                    fontSize: 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC7B8F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    child: Text(
                      "Next",
                      style: AppTextStyle.subNBodyReg.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      if (currentIndex + 1 < profileScreens.length) {
                        if (optionselection(
                            context: context, index: currentIndex)) {
                          currentIndex++;
                        }
                      } else {
                        Navigator.of(context).pushNamed(SignInScreen.routeName);
                      }
                      setState(() {});
                    },
                    // text: 'Continue',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
