class TextSelectionModel {
  final String ageRange;
  bool isSelected;

  TextSelectionModel(this.ageRange, this.isSelected);
}

List<TextSelectionModel> ageList = [
  TextSelectionModel('12-39', false),
  TextSelectionModel('30-39', false),
  TextSelectionModel('40-49', false),
  TextSelectionModel('50+', false)
];

List<TextSelectionModel> timeList = [
  TextSelectionModel('5 mins - 20 mins', false),
  TextSelectionModel('20 mins - 40 mins', false),
  TextSelectionModel('40 mins - 1 hr', false),
  TextSelectionModel('1 hr - 2 hr', false),
];
