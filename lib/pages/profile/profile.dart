import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/basics/sc-raised-button.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/notifiers/localization.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SCPage(
      header: SliverPersistentHeader(
        delegate: SliverAppBar(safeAreaPadding: MediaQuery.of(context).padding),
        pinned: true,
      ),
      children: [
        SCTitle(title: context.translate('email')),
        Editable(
          hintText: "contact@sihaclick.com",
        ),
        SCTitle(
          title: context.translate('password'),
        ),
        Editable(
          hintText: "E.#9AFO2_%33",
          obscureText: true,
        ),
        SCTitle(title: context.translate('address')),
        Editable(
          hintText: context.translate('cheraga') +
              " - " +
              context.translate('algiers'),
        ),
        SCTitle(title: context.translate('language')),
        Editable(
          hintText: context.translate('language_value'),
          input: SCDropdown<String>(
            soft: true,
            label: context.translate('language_value'),
            initial: Option(
              text: context.translate('language_value'),
              value: context.translate('language_value_short'),
            ),
            onChange: (Option option) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      title: Text(
                        context.translate('language'),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24.0,
                            bottom: 24.0,
                            right: 24.0,
                            top: 12,
                          ),
                          child: Text(
                            SCLocalizations.of(context)
                                .translate('changing_languge'),
                          ),
                        ),
                        Container(
                          height: 41,
                          child: Row(
                            children: [
                              SizedBox(width: 24),
                              Spacer(),
                              SizedBox(width: 16),
                              Expanded(
                                child: SCRaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  title: SCLocalizations.of(context)
                                      .translate('okay'),
                                  flat: true,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                              SizedBox(width: 24),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
              Future.delayed(Duration(milliseconds: 300), () {
                context
                    .read<LocalizationNotifier>()
                    .switchLocale(Locale(option.value));
              });
            },
            options: ['fr', 'ar']
                .map((e) => Option(text: context.translate(e), value: e))
                .toList(),
          ),
        ),
        SCTitle(title: context.translate('blood_type')),
        Editable(
          hintText: "A+",
          input: SCDropdown<String>(
            soft: true,
            label: ['A', 'B', 'AB', 'O'].join(', '),
            options: ['A', 'B', 'AB', 'O']
                .map((e) => Option(text: e, value: e))
                .toList(),
          ),
        ),
        SCTitle(title: context.translate('phone_number')),
        Editable(
          hintText: "0546541963",
        ),
      ],
    );
  }
}

class SliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 206;
  final double elementHeight = 62;
  final EdgeInsets safeAreaPadding;
  SliverAppBar({@required this.safeAreaPadding});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          "assets/images/generic5.jpg",
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black.withOpacity(0.75),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: shrinkOffset / expandedHeight < 1
                ? 1 - shrinkOffset / expandedHeight
                : 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: expandedHeight,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 81,
                    width: 81,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryVariant
                          .withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Mohamed Achouri",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    "@aureliensalomon",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Directionality.of(context) == TextDirection.rtl
              ? Alignment.topRight
              : Alignment.topLeft,
          child: SafeArea(
            bottom: false,
            child: Container(
              width: elementHeight - 10,
              height: elementHeight - 10,
              child: IconButton(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight + safeAreaPadding.top;

  @override
  double get minExtent => kToolbarHeight + safeAreaPadding.top;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class Editable extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final Widget input;
  Editable({this.hintText, this.obscureText = false, this.input});
  @override
  _EditableState createState() => _EditableState();
}

class _EditableState extends State<Editable> {
  bool editable = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Directionality.of(context) == TextDirection.rtl
          ? const EdgeInsets.only(
              right: 20,
              top: 20,
              bottom: 10,
            )
          : const EdgeInsets.only(
              left: 20,
              top: 20,
              bottom: 10,
            ),
      child: Row(
        children: [
          if (editable) ...[
            if (widget.input != null)
              Expanded(child: widget.input)
            else
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                  ),
                  obscureText: widget.obscureText,
                ),
              ),
            IconButton(
              onPressed: () {
                editable = !editable;
                setState(() {});
              },
              icon: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
            )
          ] else ...[
            SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.hintText,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
            ),
            FlatButton(
              onPressed: () {
                editable = !editable;
                setState(() {});
              },
              child: Text(
                context.translate('switch'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
            SizedBox(width: 16),
          ]
        ],
      ),
    );
  }
}
