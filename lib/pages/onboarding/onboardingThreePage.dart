import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sc-localization.dart';

class OnboardingThreePage extends StatelessWidget {
  final void Function() signin;
  final void Function() signup;
  OnboardingThreePage({
    this.signin,
    this.signup,
  });
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
                Padding(
                  padding: const EdgeInsets.all(29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        SCLocalizations.of(context)
                            .translate('onboarding_three_title'),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        SCLocalizations.of(context)
                            .translate('onboarding_three_subtitle'),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      // SizedBox(height: 8),
                      // Text(
                      //   SCLocalizations.of(context)
                      //       .translate('onboarding_three_description'),
                      //   style: Theme.of(context).textTheme.subtitle2,
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      LayoutBuilder(builder: (_, BoxConstraints constraints) {
                    return Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/onboarding-calendar.png",
                        height: constraints.minHeight,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: signup,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
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
                                  SCLocalizations.of(context)
                                      .translate('signup'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.chevron_right,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: signin,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Theme.of(context).colorScheme.background,
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary),
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
                                  SCLocalizations.of(context)
                                      .translate('signin'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.chevron_right,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
