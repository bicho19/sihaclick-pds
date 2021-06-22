import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-text-field.dart';
import 'package:sihaclik/helpers/sc-localization.dart';

class ProfessionalFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pureHeight = MediaQuery.of(context).size.height -
        20 -
        MediaQuery.of(context).padding.bottom;
    return Container(
      height: _pureHeight,
      child: ListView(
        children: [
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  context.translate('filter'),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                ),
              ),
              Spacer(),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
              SizedBox(width: 10),
            ],
          ),
          Container(
            color: Theme.of(context).colorScheme.onSecondary,
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Text(
              context.translate('simple_search'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                SCTextField(
                  label: context.translate('full_name'),
                  hintText: "########",
                ),
                SizedBox(height: 10),
                SCTextField(
                  label: SCLocalizations.of(context)
                      .translate('type_of_health_professional'),
                  hintText: "########",
                ),
                SizedBox(height: 10),
                SCTextField(
                  label: context.translate('specialty'),
                  hintText: "########",
                ),
                SizedBox(height: 10),
                SCTextField(
                  label: context.translate('settings'),
                  hintText: "########",
                ),
                SizedBox(height: 10),
                SCTextField(
                  label: context.translate('structure'),
                  hintText: "########",
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
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
                        SizedBox(width: 45),
                        Text(
                          context.translate('confirm'),
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
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
                // SizedBottomSpacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
