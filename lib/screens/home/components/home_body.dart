import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/components/app_snackbar.dart';
import 'package:studify/enums.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/screens/pages/home_nav.dart';
import 'package:studify/screens/pages/profile_nav.dart';
import 'package:studify/service/auth_service.dart';
import 'package:studify/service/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  int currentTab = 0;

  final List<Widget> screens = [
    // const CreateNavPage(),
    const HomeBody(),
    ProfileNavPage(userName: 'userName', email: 'email')
  ];

  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentScreen = const HomeBody();
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  Future<void> gettingUserData() async {
    try {
      final userName = await HelperFunctions.getUserNameFromSF();
      final email = await HelperFunctions.getUserEmailFromSF();
      final snapshot =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .getUserGroups();

      setState(() {
        this.userName = userName!;
        this.email = email!;
        groups = snapshot;
      });
    } catch (e) {
      // Handle any potential exceptions that might occur during the asynchronous operations.
      print('Error: $e');
    }
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

  //   // Getting a list of snapshot with stream
  //   await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //       .getUserGroups()
  //       .then((snapshot) {
  //     setState(() {
  //       groups = snapshot;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: pageStorageBucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF817DC0),
        child: const Icon(
          FontAwesomeIcons.plus,
        ),
        onPressed: () {
          popUpDialog(context);
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 3),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 30,
                      onPressed: () {
                        setState(() {
                          currentScreen = const HomeBody();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.grip,
                            size: 25,
                            color: currentTab == 0
                                ? const Color(0xFF817DC0)
                                : Colors.black,
                          ),
                          Text(
                            "Home",
                            style: GoogleFonts.manrope(
                              color: currentTab == 0
                                  ? const Color(0xFF817DC0)
                                  : Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 30,
                      onPressed: () {
                        setState(() {
                          currentScreen = ProfileNavPage(
                            userName: userName,
                            email: email,
                          );
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidUser,
                            size: 20,
                            color: currentTab == 1
                                ? const Color(0xFF817DC0)
                                : Colors.black,
                          ),
                          Text(
                            "Profile",
                            style: GoogleFonts.manrope(
                              color: currentTab == 1
                                  ? const Color(0xFF817DC0)
                                  : Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a Group",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF817DC0),
                          ),
                        )
                      : TextField(
                          onChanged: (value) {
                            groupName = value;
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF817DC0),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF817DC0),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (groupName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      await DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(
                        userName,
                        FirebaseAuth.instance.currentUser!.uid,
                        groupName,
                      )
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      // ignore: use_build_context_synchronously
                      showSnackBar(
                        context: context,
                        messageType: Message.success,
                        snackText: "Group Created Successfully.",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "CREATE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          });
        });
  }
}
