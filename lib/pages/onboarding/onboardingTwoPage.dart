import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sc-localization.dart';

class OnboardingTwoPage extends StatelessWidget {
  final void Function() setPage;
  OnboardingTwoPage({this.setPage});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Container(
        child: Opacity(
          opacity: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: LayoutBuilder(builder: (_, BoxConstraints constraints) {
                  return Container(
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: BottomWaveClipper(
                            height: 0.21 * constraints.minHeight,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF0AABFF),
                                        Color(0xFF13C2D4),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ((MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    constraints.minHeight) -
                                                0.85) >
                                            0
                                        ? (((MediaQuery.of(context).size.width /
                                                    constraints.minHeight) -
                                                0.85) *
                                            MediaQuery.of(context).size.width)
                                        : 10,
                                  ),
                                  child: Image.asset(
                                    "assets/images/doctor.png",
                                    height: 0.74 * constraints.minHeight,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Image.asset(
                                        "assets/images/sihaclick-light.png",
                                        height: 0.08 *
                                            MediaQuery.of(context).size.height,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0.00 * constraints.minHeight,
                          right: -0.26 * 0.28 * constraints.minHeight,
                          child: Container(
                            width: 0.26 * constraints.minHeight,
                            height: 0.26 * constraints.minHeight,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF046489).withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            SCLocalizations.of(context)
                                .translate('onboarding_two_title'),
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            SCLocalizations.of(context)
                                .translate('onboarding_two_subtitle'),
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            SCLocalizations.of(context)
                                .translate('onboarding_two_description'),
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
                        margin: EdgeInsets.only(right: 29),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
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
                              context.translate('next'),
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                            Spacer(),
                            Icon(Icons.chevron_right,
                                color: Theme.of(context).colorScheme.secondary),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  BottomWaveClipper({@required this.height});
  final double height;
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);

    var firstControlPoint = Offset(size.width * 1 / 3, size.height);
    var firstEndPoint = Offset(size.width * 0.5, size.height - height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width * 1 / 3 * 2, size.height - 2 * height);
    var secondEndPoint = Offset(size.width, size.height - height * 2);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
