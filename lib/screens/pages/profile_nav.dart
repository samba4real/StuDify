import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/screens/sign_in/sign_in_screen.dart';
import 'package:studify/service/auth_service.dart';

// ignore: must_be_immutable
class ProfileNavPage extends StatefulWidget {
  String userName;
  String email;
  ProfileNavPage({super.key, required this.userName, required this.email});

  @override
  State<ProfileNavPage> createState() => _ProfileNavPageState();
}

class _ProfileNavPageState extends State<ProfileNavPage> {
  
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    // gettingUserData();
  }

  // gettingUserData() async {
  //   await HelperFunctions.getUserNameFromSF().then((value) {
  //     setState(() {
  //       userName = value!;
  //     });
  //   });

  //   await HelperFunctions.getUserEmailFromSF().then((value) {
  //     setState(() {
  //       email = value!;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.userCircle,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                "User Name: ${widget.userName}",
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 3),
              const SizedBox(height: 20),
              Text(
                "Email: ${widget.email}",
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(height: 3),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content:
                              const Text("Are you sure you want to Logout?"),
                          title: const Text("SIGN OUT"),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.xmark,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                authService.userSignOut();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                FontAwesomeIcons.check,
                                color: Colors.green,
                              ),
                            )
                          ],
                        );
                      });
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                        color: const Color(0xFF817DC0),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.signOut,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "SIGOUT",
                          style: GoogleFonts.lora(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}

