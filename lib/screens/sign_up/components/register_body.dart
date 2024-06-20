import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:studify/components/app_snackbar.dart';
import 'package:studify/constants.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/helper/keyboard.dart';
import 'package:studify/screens/home/home_screen.dart';
import 'package:studify/screens/sign_in/sign_in_screen.dart';
import 'package:studify/screens/sign_up/components/register.dart';
import 'package:studify/service/auth_service.dart';
import 'package:studify/size_config.dart';
import 'package:studify/theme/texts_style.dart';

import '../../../enums.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  bool _isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String password = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple))
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
                                  child: Text('Register a New Account',
                                      style: AppTextStyle.titleHeading.copyWith(
                                          fontSize:
                                              getProportionateScreenHeight(
                                                  50))),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(70),
                                ),
                                RegisterForm(
                                  formkey: formkey,
                                  userName: (userName) {
                                    name = userName;
                                  },
                                  userEmail: (user_email) {
                                    email = user_email;
                                  },
                                  userPassword: (user_password) {
                                    password = user_password;
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
                                      "Sign up",
                                      style: AppTextStyle.subNBodyReg.copyWith(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      register();
                                      //     KeyboardUtil.hideKeyboard(context);
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
                                          'Already Have Account ? ',
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
                                                SignInScreen.routeName);
                                          },
                                          child: Text(
                                            'Sign in',
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

  register() async {
    print(email);
    print(password);
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
    await authService
        .registerUserWithEmailandPassword(name, email, password)
        .then((value) async {
      if (value == true) {
        //saving the sf
        await HelperFunctions.saveUserLoggedInStatus(true);
        await HelperFunctions.saveUserNameSF(name);
        await HelperFunctions.saveUserEmailSF(email);

// ignore: use_build_context_synchronously
        showSnackBar(
          context: context,
          messageType: Message.success,
          snackText: 'Account Created Successfully',
        );

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(HomeScreen.routeName);
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
