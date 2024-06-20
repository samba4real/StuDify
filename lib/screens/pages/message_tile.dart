import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sendbyMe;
  const MessageTile(
      {super.key,
      required this.message,
      required this.sender,
      required this.sendbyMe});

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.sendbyMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: 10,
        bottom: 4,
        left: widget.sendbyMe ? 0 : 24,
        right: widget.sendbyMe ? 10 : 0,
      ),
      child: Container(
        margin: widget.sendbyMe
            ? const EdgeInsets.only(left: 30)
            : const EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: widget.sendbyMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
          color: widget.sendbyMe
              ? Theme.of(context).primaryColor
              : Colors.grey.shade700,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sender.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
