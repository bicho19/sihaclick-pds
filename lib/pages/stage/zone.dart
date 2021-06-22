import 'package:flutter/material.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/store/abstracts/widget-view.dart';
import 'package:sihaclik/store/models/town.dart';
import 'package:sihaclik/store/models/wilaya.dart';
import 'package:sihaclik/store/notifiers/locations.dart';

class StageZone extends StatefulWidget {
  StageZone({
    Key key,
    this.bottom,
  }) : super(key: key);
  final double bottom;
  @override
  _StageZoneController createState() => _StageZoneController();
}

class _StageZoneController extends State<StageZone> {
  Wilaya wilaya;
  @override
  Widget build(BuildContext context) => _StageZoneView(this);

  void setWilaya(Option option) {
    this.wilaya = option.value;
    setState(() {});
  }
}

class _StageZoneView extends WidgetView<StageZone, _StageZoneController> {
  _StageZoneView(_StageZoneController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: state.widget.bottom,
      ),
      children: [
        Text(
          SCLocalizations.of(context)
                  .translate('geographical_area_of_the_desired_internship') +
              ":",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 20),
        Text(
          context.translate('wilaya'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 4),
        SCDropdown<Wilaya>(
          soft: true,
          color: Theme.of(context).colorScheme.primaryVariant,
          label: "",
          options: context
              .watch<LocationsNotifier>()
              .wilayas
              .map(
                (wilaya) => Option(text: wilaya.nom, value: wilaya),
              )
              .toList(),
        ),
        SizedBox(height: 20),
        Text(
          context.translate('town'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 4),
        SCDropdown<Town>(
          soft: true,
          color: Theme.of(context).colorScheme.primaryVariant,
          label: "",
          options: context
              .watch<LocationsNotifier>()
              .wilayas
              .first
              .communes
              .map(
                (town) => Option(text: town.nom, value: town),
              )
              .toList(),
        ),
      ],
    );
  }
}
