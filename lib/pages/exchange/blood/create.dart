import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/basics/sc-text-field.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:sihaclik/elements/controls/sc-toggle-group.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/store/abstracts/widget-view.dart';
import 'package:sihaclik/store/models/town.dart';
import 'package:sihaclik/store/models/wilaya.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/notifiers/exchanges.dart';
import 'package:sihaclik/store/notifiers/locations.dart';

class BloodCreatePage extends StatefulWidget {
  @override
  _BloodCreatePageController createState() => _BloodCreatePageController();
}

class _BloodCreatePageController extends State<BloodCreatePage> {
  @override
  Widget build(BuildContext context) => _BloodCreatePageView(this);

  TextEditingController phoneController = TextEditingController();
  Wilaya wilaya;
  Town town;
  String type = 'Positive';
  String group = 'A';

  void setGroup(String group) {
    this.group = group;
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

  void create() {
    context.read<ExchangesNotifier>().createBlood(
          type: type,
          group: group,
          date: DateTime.now(),
          wilaya: wilaya,
          town: town,
          phone: phoneController.text,
        );
    Navigator.of(context).pop();
  }
}

class _BloodCreatePageView
    extends WidgetView<BloodCreatePage, _BloodCreatePageController> {
  _BloodCreatePageView(_BloodCreatePageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return SCModal(
      title: context.translate('add_blood_donation'),
      children: [
        SizedBox(height: 20),
        BloodGroups(
          initial: state.group,
          onChange: state.setGroup,
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
        SizedBox(height: 10),
        SCTextField(
          label: context.translate('phone_number'),
          hintText: "+213",
          controller: state.phoneController,
        ),
        SizedBox(height: 40),
        GestureDetector(
          onTap: state.create,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.25),
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

class BloodGroups extends StatelessWidget {
  const BloodGroups({
    Key key,
    this.initial,
    this.onChange,
  }) : super(key: key);

  final String initial;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      runSpacing: 16,
      spacing: 16,
      children: [
        for (final group in ['A', 'B', 'AB', 'O'])
          GestureDetector(
            onTap: () => onChange(group),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 1,
                  color: initial == group
                      ? Theme.of(context).colorScheme.primaryVariant
                      : Theme.of(context)
                          .colorScheme
                          .primaryVariant
                          .withOpacity(0.1),
                ),
              ),
              child: Image.asset(
                "assets/images/blood-${group.toLowerCase()}.png",
                width: 85,
                height: 75,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
      ],
    );
  }
}

class BloodToggle extends StatelessWidget {
  const BloodToggle({
    Key key,
    this.initial,
    this.onChange,
  }) : super(key: key);

  final String initial;
  final void Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SCToggle(
          selected: initial == 'Positive',
          onTap: () => onChange('Positive'),
          color: Theme.of(context).colorScheme.primaryVariant,
          child: Text(context.translate('positive'),
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    fontWeight: FontWeight.bold,
                  )),
        ),
        Spacer(),
        SCToggle(
          selected: initial == 'Negative',
          onTap: () => onChange('Negative'),
          color: Theme.of(context).colorScheme.primaryVariant,
          child: Text(
            context.translate('negative'),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
