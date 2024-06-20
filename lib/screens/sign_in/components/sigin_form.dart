import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../theme/texts_style.dart';

class SignInForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final ValueChanged<String>? userName;
  final ValueChanged<String>? userEmail;
  final ValueChanged<String>? userPassword;
  const SignInForm(
      {Key? key,
      required this.formkey,
      this.userEmail,
      this.userPassword,
      this.userName})
      : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool nameValid = false;
  bool emailValid = false;
  bool passwordValid = false;
  bool passwordHidden = true;
  String? name;
  String? email;
  String? password;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      errors.add(error);
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      errors.remove(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: const Duration(milliseconds: 1000),
      from: 30,
      duration: const Duration(milliseconds: 800),
      child: Form(
        key: widget.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return Constants.kNameNullError;
                } else if (!Constants.nameValidatorRegExp.hasMatch(value)) {
                  return Constants.kInvalidNameError;
                }
                return null;
              },
              onSaved: (value) => name = value,
              textInputAction: TextInputAction.next,
              style: AppTextStyle.subNBodyBold.copyWith(fontSize: 16),
              keyboardType: TextInputType.name,
              cursorColor: Constants.kPrimaryColor,
              onChanged: (value) {
                if (Constants.nameValidatorRegExp.hasMatch(value)) {
                  nameValid = true;
                } else {
                  nameValid = false;
                }
                setState(() {
                  name = value;
                  widget.userName?.call(name!);
                });
              },
              decoration: InputDecoration(
                label: Text(
                  'Name',
                  style: AppTextStyle.subNBodyReg
                      .copyWith(fontSize: 16, color: Colors.black38),
                ),
                suffixIcon: nameValid
                    ? const Icon(
                        Icons.done,
                        color: Constants.kPrimaryColor,
                      )
                    : null,
              ),
            ),
             SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return Constants.kEmailNullError;
                } else if (!Constants.emailValidatorRegExp.hasMatch(value)) {
                  return Constants.kInvalidEmailError;
                }
                return null;
              },
              onSaved: (value) => email = value,
              textInputAction: TextInputAction.next,
              style: AppTextStyle.subNBodyBold.copyWith(fontSize: 16),
              keyboardType: TextInputType.emailAddress,
              cursorColor: Constants.kPrimaryColor,
              onChanged: (value) {
                if (Constants.emailValidatorRegExp.hasMatch(value)) {
                  emailValid = true;
                } else {
                  emailValid = false;
                }
                setState(() {
                  email = value;
                  widget.userEmail?.call(email!);
                });
              },
              decoration: InputDecoration(
                label: Text(
                  'Email',
                  style: AppTextStyle.subNBodyReg
                      .copyWith(fontSize: 16, color: Colors.black38),
                ),
                suffixIcon: emailValid
                    ? const Icon(
                        Icons.done,
                        color: Constants.kPrimaryColor,
                      )
                    : null,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return Constants.kPassNullError;
                } else if (!Constants.passwordValidatorRegExp.hasMatch(value)) {
                  return Constants.kShortPassError;
                }
                return null;
              },
              onSaved: (value) => password = value,
              textInputAction: TextInputAction.next,
              style: AppTextStyle.subNBodyBold.copyWith(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Constants.kPrimaryColor,
              onChanged: (value) {
                if (Constants.passwordValidatorRegExp.hasMatch(value)) {
                  passwordValid = true;
                } else {
                  passwordValid = false;
                }
                setState(() {
                  password = value;
                  widget.userPassword?.call(password!);
                });
              },
              obscureText: passwordHidden,
              decoration: InputDecoration(
                label: Text(
                  'Password',
                  style: AppTextStyle.subNBodyReg
                      .copyWith(fontSize: 16, color: Colors.black38),
                ),
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => passwordHidden = !passwordHidden),
                  icon: Icon(
                    passwordHidden ? Icons.visibility : Icons.visibility_off,
                    color: Constants.kPrimaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
