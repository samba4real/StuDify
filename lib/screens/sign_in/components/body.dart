import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:studify/components/app_snackbar.dart';
import 'package:studify/constants.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/helper/keyboard.dart';
import 'package:studify/screens/home/home_screen.dart';
import 'package:studify/screens/sign_in/components/sigin_form.dart';
import 'package:studify/screens/sign_up/sign_up_screen.dart';
import 'package:studify/service/auth_service.dart';
import 'package:studify/size_config.dart';
import 'package:studify/theme/texts_style.dart';

import '../../../enums.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  String name = "";
  String email = "";
  String password = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.purple))
          : SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: Constants.kPagePadding,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeInDown(
                                  from: 30,
                                  duration: const Duration(milliseconds: 800),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(100),
                                      ),
                                      Image.asset(
                                        Constants.logo,
                                        height:
                                            getProportionateScreenHeight(50),
                                        color: const Color(0xFF6F35A5),
                                      ),
                                      Text(
                                        'StuDify',
                                        style: AppTextStyle.titleHeading
                                            .copyWith(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        20)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                FadeInDown(
                                  delay: const Duration(milliseconds: 500),
                                  from: 30,
                                  duration: const Duration(milliseconds: 800),
                                  child: Text('Log in with Email',
                                      style: AppTextStyle.titleHeading.copyWith(
                                          fontSize:
                                              getProportionateScreenHeight(
                                                  50))),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(70),
                                ),
                                SignInForm(
                                  formkey: formkey,
                                  userName: (userName) {
                                    name = userName;
                                  },
                                  userEmail: (userEmail) {
                                    email = userEmail;
                                  },
                                  userPassword: (userPassword) {
                                    password = userPassword;
                                  },
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6F35A5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      "Sign in",
                                      style: AppTextStyle.subNBodyReg.copyWith(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      login();
                                      // SizeConfig().init(context);
                                      // KeyboardUtil.hideKeyboard(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'New to StuDify? ',
                                          style: AppTextStyle.subNBodyMeduim
                                              .copyWith(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    16),
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(
                                          width: getProportionateScreenWidth(5),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            KeyboardUtil.hideKeyboard(context);
                                            Navigator.of(context).pushNamed(
                                                SignUpScreen.routeName);
                                          },
                                          child: Text(
                                            'Sign up',
                                            style: AppTextStyle.subNBodyBold
                                                .copyWith(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      16),
                                              color: Constants.kPrimaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
    await authService
        .signInUserWithEmailandPassword(email, password)
        .then((value) async {
      if (value == true) {
        //saving the sf
        await HelperFunctions.saveUserLoggedInStatus(true);
        await HelperFunctions.saveUserNameSF(name);
        await HelperFunctions.saveUserEmailSF(email);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(HomeScreen.routeName);
        // ignore: use_build_context_synchronously
        showSnackBar(
          context: context,
          messageType: Message.success,
          snackText: 'You have Sign In Successfully',
        );
      } else {
        showSnackBar(
          context: context,
          messageType: Message.error,
          snackText: value,
        );
      }
      setState(() {
        _isLoading = false;
      });
    });
  }
}
