import 'package:flutter/material.dart';
import 'package:sihaclik/pages/onboarding/onboardingOnePage.dart';
import 'package:sihaclik/pages/onboarding/onboardingThreePage.dart';
import 'package:sihaclik/pages/onboarding/onboardingTwoPage.dart';

class OnboardingPage extends StatefulWidget {
  final PageController _controller = PageController();
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController get controller => widget._controller;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          OnboardingOnePage(
            setPage: () => setPage(1),
          ),
          OnboardingTwoPage(
            setPage: () => setPage(2),
          ),
          OnboardingThreePage(
            signin: () => Navigator.of(context).pushNamed("/sign-in"),
            signup: () => Navigator.of(context).pushNamed("/sign-up"),
          ),
        ],
      ),
    );
  }

  void setPage(index) {
    pageIndex = index;
    controller.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    setState(() {});
  }
}
