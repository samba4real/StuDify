import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/components/app_snackbar.dart';
import 'package:studify/enums.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/screens/pages/chat_page.dart';
import 'package:studify/service/database_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? userName = "";
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  User? user;
  bool isJoined = false;

  getCurrentUserIdandName() async {
    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserIdandName();
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Search",
          style: GoogleFonts.manrope(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Search Groups...",
                      hintStyle: GoogleFonts.manrope(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    searchMethod();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : searchGroupMethod()
        ],
      ),
    );
  }

  searchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService()
          .searchGroup(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  searchGroupMethod() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return groupSearchTile(
                userName!,
                searchSnapshot!.docs[index]["groupName"],
                searchSnapshot!.docs[index]["groupId"],
                searchSnapshot!.docs[index]["admin"],
              );
            },
          )
        : Container();
  }

  userJoinedorNot(
      String userName, groupId, String groupName, String admin) async {
    await DatabaseService(uid: user!.uid)
        .isUserJoined(groupName, groupId, userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
  }

  Widget groupSearchTile(
      String userName, String groupName, String groupId, String admin) {
    userJoinedorNot(userName, groupId, groupName, admin);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              groupName.substring(0, 1).toUpperCase(),
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            groupName,
            style: GoogleFonts.manrope(fontWeight: FontWeight.w600),
          ),
          subtitle: Text("Admin: ${getName(admin)}"),
          trailing: InkWell(
            onTap: () async {
              await DatabaseService(uid: user!.uid)
                  .GroupJoinOrExit(groupId, userName, groupName);
              if (isJoined == true) {
                setState(() {
                  isJoined = !isJoined;
                });

                // ignore: use_build_context_synchronously
                showSnackBar(
                    context: context,
                    messageType: Message.success,
                    snackText: "Successfully Joined!");
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        userName: userName,
                        groupId: groupId,
                        groupName: groupName,
                      ),
                    ),
                  );
                });
              } else {
                setState(() {
                  isJoined = !isJoined;
                });
                // ignore: use_build_context_synchronously
                showSnackBar(
                    context: context,
                    messageType: Message.warning,
                    snackText: "Left the Group $groupName");
              }
            },
            child: isJoined
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                        border: Border.all(color: Colors.white, width: 1)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      "Joined",
                      style: GoogleFonts.manrope(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      "Join",
                      style: GoogleFonts.manrope(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
