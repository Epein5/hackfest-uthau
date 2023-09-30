class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Arrive With Confidence, Depart With Ease",
    image: "assets/onboard1.png",
    desc: "Embrace the Future of Bus Travel with Facial Recognition",
  ),
  OnboardingContents(
    title: "Your Face, Your Pass",
    image: "assets/onboard2.png",
    desc: "Say Goodbye to Cash and Hello to the Future of Bus Travel.",
  ),
  OnboardingContents(
    title: "Your Journey, Your Control",
    image: "assets/onboard3.png",
    desc: "Keep Your Adventures on Track with our Live Tracking Feature",
  ),
];
