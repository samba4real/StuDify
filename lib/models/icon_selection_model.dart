import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Model and list for selections with IconData

class IconSelectionModel {
  final String item;
  bool isSelected;
  final IconData icon;
  final Color? color;
  final String? image;

  IconSelectionModel(
      this.item, this.isSelected, this.icon, this.color, this.image);
}

List<IconSelectionModel> genderList = [
  IconSelectionModel('Male', false, Icons.male, const Color(0xFF6F35A5),
      ("assets/images/ucc-logo.png")),
  IconSelectionModel('Female', false, Icons.female, const Color(0xFF6F35A5),
      ("assets/images/ucc-logo.png")),
];

List<IconSelectionModel> whenToReadList = [
  IconSelectionModel('UCC', false, Icons.emoji_food_beverage_outlined,
      const Color(0xFF6F35A5), ("assets/images/ucc-logo.png")),
  IconSelectionModel(
      'KNUST',
      false,
      Icons.nightlight_round_outlined,
      const Color(0xFF6F35A5),
      ("assets/images/KNUST_logo-Vector_0-removebg-preview.png")),
  IconSelectionModel('GCTU', false, Icons.local_pizza_outlined,
      const Color(0xFF6F35A5), ("assets/images/cropped-logo_favicon.png")),
  IconSelectionModel(
      'UG',
      false,
      Icons.local_taxi_outlined,
      const Color(0xFF6F35A5),
      ("assets/images/4445-universite-ghana-removebg-preview.png"))
];

List<IconSelectionModel> goalList = [
  IconSelectionModel('Coding', false, FontAwesomeIcons.fileCode,
      const Color(0xFF6F35A5), ("assets/images/ucc-logo.png")),
  IconSelectionModel(
      'Networking',
      false,
      FontAwesomeIcons.server,
      const Color(0xFF6F35A5),
      ("assets/images/KNUST_logo-Vector_0-removebg-preview.png")),
  IconSelectionModel('CyberSecurity', false, FontAwesomeIcons.userSecret,
      const Color(0xFF6F35A5), ("assets/images/cropped-logo_favicon.png")),
  IconSelectionModel(
      'Databases',
      false,
      FontAwesomeIcons.database,
      const Color(0xFF6F35A5),
      ("assets/images/4445-universite-ghana-removebg-preview.png"))
];
