import '../constants.dart';

class OnboardingModel {
  final String assetName;
  final String title;
  final String subTitle;

  OnboardingModel(
      {required this.assetName, required this.title, required this.subTitle});
}

List<OnboardingModel> onboardingItems = [
  OnboardingModel(
      assetName: Constants.onBoardingSlideOne,
      title: 'Habit of reading',
      subTitle: 'Reading Becomes Fun and Easy'),
  OnboardingModel(
      assetName: Constants.onBoardingSlideTwo,
      title: 'Learn anyhwere',
      subTitle: 'Share Essential Ideas & Documents'),
  OnboardingModel(
      assetName: Constants.onBoardingSlideThree,
      title: 'Join a Room and Meet',
      subTitle: 'Students that have same Interest')
];
