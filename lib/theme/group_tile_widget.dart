import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studify/screens/pages/chat_page.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile({
    super.key,
    required this.userName,
    required this.groupId,
    required this.groupName,
  });

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userName: widget.userName,
              groupId: widget.groupId,
              groupName: widget.groupName,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 30,
              child: Text(
                widget.groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              widget.groupName,
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Joined the Room as ${widget.userName}",
              style: GoogleFonts.manrope(
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
