import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/exchange/blood/create.dart';
import 'package:sihaclik/store/abstracts/widget-view.dart';
import 'package:sihaclik/store/models/town.dart';
import 'package:sihaclik/store/models/wilaya.dart';
import 'package:sihaclik/store/notifiers/exchanges.dart';
import 'package:sihaclik/store/notifiers/locations.dart';

class BloodFilterPage extends StatefulWidget {
  @override
  _BloodFilterPageController createState() => _BloodFilterPageController();
}

class _BloodFilterPageController extends State<BloodFilterPage> {
  @override
  Widget build(BuildContext context) => _BloodFilterPageView(this);

  TextEditingController phoneController = TextEditingController();
  Wilaya wilaya;
  Town town;
  String type = 'Positive';
  String group = 'A';

  void setGroup(Option option) {
    this.group = option.value;
    setState(() {});
  }

  void setType(String type) {
    this.type = type;
    setState(() {});
  }

  void setWilaya(Option option) {
    this.wilaya = option.value;
    setState(() {});
  }

  void setTown(Option option) {
    this.town = option.value;
    setState(() {});
  }

  void filter() {
    context.read<ExchangesNotifier>().filterBlood(
          type: type,
          group: group,
          wilaya: wilaya,
          town: town,
        );
    print("""
type: $type,
group: $group,
wilaya: $wilaya,
town: $town,
        """);
    Navigator.of(context).pop();
  }
}

class _BloodFilterPageView
    extends WidgetView<BloodFilterPage, _BloodFilterPageController> {
  _BloodFilterPageView(_BloodFilterPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return SCModal(
      title: context.translate('filter'),
      children: [
        // SizedBox(height: 20),
        // Container(
        //   color: Theme.of(context).colorScheme.onSecondary,
        //   padding: EdgeInsets.all(15),
        //   alignment: Alignment.center,
        //   child: Text(
        //     context.translate('blood_search'),
        //     textAlign: TextAlign.center,
        //     style: Theme.of(context).textTheme.headline6.copyWith(
        //           color: Theme.of(context).colorScheme.onBackground,
        //           fontWeight: FontWeight.bold,
        //         ),
        //   ),
        // ),
        SizedBox(height: 20),
        Text(
          context.translate('blood_group') + ":",
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 4),
        SCDropdown(
          soft: true,
          color: Theme.of(context).colorScheme.primaryVariant,
          label: ['A', 'B', 'AB', 'O'].join(', '),
          initial: Option(text: state.group, value: state.group),
          onChange: state.setGroup,
          options: ['A', 'B', 'AB', 'O']
              .map((e) => Option(text: e, value: e))
              .toList(),
        ),
        SizedBox(height: 20),
        BloodToggle(
          initial: state.type,
          onChange: state.setType,
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
          onChange: state.setWilaya,
          initial: state.wilaya != null
              ? Option(text: state.wilaya.nom, value: state.wilaya)
              : null,
          options: context
              .watch<LocationsNotifier>()
              .wilayas
              .map(
                (wilaya) => Option(text: wilaya.nom, value: wilaya),
              )
              .toList(),
        ),
        SizedBox(height: 10),
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
          onChange: state.setTown,
          initial: state.town != null
              ? Option(text: state.town.nom, value: state.town)
              : null,
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
        SizedBox(height: 40),
        GestureDetector(
          onTap: state.filter,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.primaryVariant,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  color: Theme.of(context)
                      .colorScheme
                      .primaryVariant
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
      ],
    );
  }
}
