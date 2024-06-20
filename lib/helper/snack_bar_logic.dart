import 'package:flutter/material.dart';
import 'package:studify/components/app_snackbar.dart';
import 'package:studify/enums.dart';

import '../models/icon_selection_model.dart';
import '../models/text_selection_model.dart';

bool optionselection({required int index, required BuildContext context}) {
  switch (index) {
    case 0:
      {
        var genderCondition =
            genderList.where((element) => element.isSelected == true);
        if (genderCondition.isEmpty) {
          showSnackBar(
              context: context,
              messageType: Message.warning,
              snackText: 'You need to select an option');
          return false;
        }
        return true;
      }
    case 1:
      {
        var ageCondition =
            ageList.where((element) => element.isSelected == true);
        if (ageCondition.isEmpty) {
          showSnackBar(
              context: context,
              messageType: Message.warning,
              snackText: 'You need to select an option');
          return false;
        }
        return true;
      }
    case 2:
      {
        var whenToReadCondition =
            whenToReadList.where((element) => element.isSelected == true);
        if (whenToReadCondition.isEmpty) {
          showSnackBar(
              context: context,
              messageType: Message.warning,
              snackText: 'You need to select at least an option');
          return false;
        }
        return true;
      }
    case 3:
      {
        var goalsCondition =
            goalList.where((element) => element.isSelected == true);
        if (goalsCondition.isEmpty) {
          showSnackBar(
              context: context,
              messageType: Message.warning,
              snackText: 'You need to select at least an option');
          return false;
        }
        return true;
      }

    default:
      return false;
  }
}
