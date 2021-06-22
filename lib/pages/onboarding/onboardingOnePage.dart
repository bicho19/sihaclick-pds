import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sc-localization.dart';

class OnboardingOnePage extends StatelessWidget {
  final void Function() setPage;
  OnboardingOnePage({this.setPage});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Container(
          child: Opacity(
            opacity: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Image.asset(
                  "assets/images/sihaclick-dark.png",
                  height: 0.08 * MediaQuery.of(context).size.height,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 8),
                Expanded(
                  child:
                      LayoutBuilder(builder: (_, BoxConstraints constraints) {
                    return Container(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: -0.35 / 2 * constraints.minHeight,
                            child: Container(
                              width: 0.35 * constraints.minHeight,
                              height: 0.35 * constraints.minHeight,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/onboarding-person.png",
                              height: 0.82 * constraints.minHeight,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -0.21 / 2 * constraints.minHeight,
                            child: Container(
                              width: 0.21 * constraints.minHeight,
                              height: 0.21 * constraints.minHeight,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        SCLocalizations.of(context)
                            .translate("onboarding_one_title"),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        SCLocalizations.of(context)
                            .translate("onboarding_one_subtitle"),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        SCLocalizations.of(context)
                            .translate("onboarding_one_description"),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: setPage,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 29),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.25),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          context.translate("next"),
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
