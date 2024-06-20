import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/screens/pages/search_page.dart';
import 'package:studify/service/auth_service.dart';
import 'package:studify/service/database_service.dart';
import 'package:studify/size_config.dart';
import 'package:studify/theme/group_tile_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String? userName = "";
  AuthService authService = AuthService();
  Stream? groups;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  // String manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  Future<void> getUserName() async {
    try {
      final value = await HelperFunctions.getUserNameFromSF();
      setState(() {
        userName = value;
      });

      final snapshot =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .getUserGroups();
      setState(() {
        groups = snapshot;
      });
    } catch (e) {
      // Handle any potential exceptions that might occur during the asynchronous operations.
      print('Error: $e');
    }
  }

  // getUserName() async {
  //   HelperFunctions.getUserNameFromSF().then((value) {
  //     setState(() {
  //       userName = value!;
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
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: Color(0xFF817DC0),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/meditation_bg.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9681EB),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/bell.svg",
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                  Text(
                    "Welcome, \n$userName",
                    style: GoogleFonts.lora(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 160, 0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TextField(
                        // controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: "Search",
                          icon: SvgPicture.asset("assets/icons/search.svg"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Expanded(
                    child: groupList(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make checks
        if (snapshot.hasData) {
          if (snapshot.data["groups"].length != null) {
            if (snapshot.data["groups"].length != 0) {
              return ListView.builder(
                  itemCount: snapshot.data["groups"].length,
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        snapshot.data["groups"].length - index - 1;
                    return GroupTile(
                      userName: snapshot.data["name"],
                      groupId: getId(snapshot.data["groups"][reverseIndex]),
                      groupName: getName(
                        snapshot.data["groups"][reverseIndex],
                      ),
                    );
                  }
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     childAspectRatio: .85,
                  //     crossAxisSpacing: 20,
                  //     mainAxisSpacing: 20,
                  //   ),
                  );
            } else {
              return noGroupWight();
            }
          } else {
            return noGroupWight();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF817DC0),
            ),
          );
        }
      },
    );
  }

  noGroupWight() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.circlePlus,
            size: 70,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 15),
          Center(
              child: Text(
            "There is Currently No Groups. Join or Create One.",
            style: GoogleFonts.manrope(fontSize: 15),
          ))
        ],
      ),
    );
  }
}
