import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/screens/home/home_screen.dart';
import 'package:studify/service/database_service.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfo(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.adminName});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  Stream? members;

  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((value) {
      members = value;
    });
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Room Details",
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content:
                          const Text("Are you sure you want to Exit Group?"),
                      title: const Text("Exit"),
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
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .GroupJoinOrExit(
                              widget.groupId,
                              getName(widget.adminName),
                              widget.groupName,
                            )
                                .whenComplete(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            });
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
            icon: const Icon(
              FontAwesomeIcons.externalLinkSquare,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      widget.groupName.substring(0, 1).toUpperCase(),
                      style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Room Name: ${widget.groupName}",
                        style: GoogleFonts.manrope(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Admin: ${getName(widget.adminName)}",
                        style: GoogleFonts.manrope(
                          fontSize: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            memberList(),
          ],
        ),
      ),
    );
  }

  // memberList() {
  //   return StreamBuilder(
  //       stream: members,
  //       builder: (context, AsyncSnapshot snapshot) {
  //         if (snapshot.hasData) {
  //           if (snapshot.data["members"] != null) {
  //             if (snapshot.data["members"].length != 0) {
  //               return ListView.builder(
  //                 itemCount: snapshot.data["members"].length,
  //                 shrinkWrap: true,
  //                 itemBuilder: (context, index) {
  //                   return Container(
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: 5, vertical: 10),
  //                     child: ListTile(
  //                       leading: CircleAvatar(
  //                         radius: 30,
  //                         backgroundColor: Theme.of(context).primaryColor,
  //                         child: Text(
  //                           getName(snapshot.data["members"][index])
  //                               .substring(0, 1)
  //                               .toUpperCase(),
  //                           style: GoogleFonts.manrope(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                       title: Text(
  //                         getName(
  //                           snapshot.data["members"][index],
  //                         ),
  //                       ),
  //                       // subtitle: Text(getId(snapshot.data["members"][index])),
  //                     ),
  //                   );
  //                 },
  //               );
  //             } else {
  //               return Center(
  //                 child: Text(
  //                   "NO MEMBERS",
  //                   style: GoogleFonts.manrope(
  //                     fontSize: 30,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               );
  //             }
  //           } else {
  //             return Center(
  //               child: Text(
  //                 "NO MEMBERS",
  //                 style: GoogleFonts.manrope(
  //                   fontSize: 30,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             );
  //           }
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(
  //                 color: Theme.of(context).primaryColor),
  //           );
  //         }
  //       });
  // }

  memberList() {
    return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['members'] != null) {
            if (snapshot.data['members'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['members'].length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(getName(snapshot.data['members'][index])),
                      subtitle: Text(getId(snapshot.data['members'][index])),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("NO MEMBERS"),
              );
            }
          } else {
            return const Center(
              child: Text("NO MEMBERS"),
            );
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }
      },
    );
  }
}
