import 'package:flutter/material.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/screens/onboarding/components/onboarding_widget.dart';
import 'package:studify/screens/onboarding/components/page_indicator.dart';
import 'package:studify/screens/profile_setup/profile_setup_screen.dart';
import '../../../constants.dart';
import '../../../models/onboarding_model.dart';
import '../../../size_config.dart';
import '../../../theme/texts_style.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController controller = PageController();
  int currentIndex = 0;
  bool _isSignedIn = false;

  Future<void> initApp() async {
    getUserLoggedInStatus();
  }

  Future<void> getUserLoggedInStatus() async {
    bool? value = await HelperFunctions.getUserLoggedInStatus();
    if (value != null) {
      setState(() {
        _isSignedIn = value;
      });
    }
    print(value);
  }

  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Constants.kPagePadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '${currentIndex + 1}',
                          style: AppTextStyle.titleHeading.copyWith(
                            fontSize: getProportionateScreenHeight(30),
                          ),
                        ),
                        TextSpan(
                          text: ' /3',
                          style: AppTextStyle.titleHeading.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(ProfileSetupScreen.routeName),
                  child: Text(
                    'Skip',
                    style: AppTextStyle.subNBodyReg.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF6F35A5),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                itemCount: onboardingItems.length,
                onPageChanged: (value) => setState(() => currentIndex = value),
                itemBuilder: ((context, index) {
                  return OnboardingWidget(
                      imageAsset: onboardingItems[index].assetName,
                      title: onboardingItems[index].subTitle,
                      subTitle: onboardingItems[index].title);
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PageIndicator(
                  count: 3,
                  controller: controller,
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: const Color(0xFFC7B8F5),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    child: Text(
                      'Next',
                      style: AppTextStyle.subNBodyReg.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if ((currentIndex + 1) < onboardingItems.length) {
                        controller.nextPage(
                            duration: Constants.kDuration,
                            curve: Curves.easeInOut);
                      } else {
                        Navigator.of(context)
                            .pushReplacementNamed(ProfileSetupScreen.routeName);
                      }
                    },
                    // text: 'Next',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
