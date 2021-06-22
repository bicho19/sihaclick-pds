import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/basics/sc-text-field.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/store/abstracts/widget-view.dart';
import 'package:sihaclik/store/models/town.dart';
import 'package:sihaclik/store/models/wilaya.dart';
import 'package:sihaclik/store/notifiers/exchanges.dart';
import 'package:sihaclik/store/notifiers/locations.dart';
import 'package:provider/provider.dart';

class MedicineFilterPage extends StatefulWidget {
  @override
  MedicineFilterPageController createState() => MedicineFilterPageController();
}

class MedicineFilterPageController extends State<MedicineFilterPage> {
  @override
  Widget build(BuildContext context) => MedicineFilterPageView(this);

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    final filters = context.read<ExchangesNotifier>().filters['medicines'];
    wilaya = filters['wilaya'];
    town = filters['town'];
    titleController = TextEditingController(text: filters['title']);
    dosageController = TextEditingController(text: filters['dosage']);
  }

  TextEditingController titleController;
  TextEditingController dosageController;
  Wilaya wilaya;
  void setWilaya(Option option) {
    this.wilaya = option.value;
    setState(() {});
  }

  Town town;
  void setTown(Option option) {
    this.town = option.value;
    setState(() {});
  }

  void filter() {
    context.read<ExchangesNotifier>().filterMedicine(
          title: titleController.text,
          dosage: dosageController.text,
          wilaya: wilaya,
          town: town,
        );
    print("""
          title: ${titleController.text},
          dosage: ${dosageController.text},
          wilaya: $wilaya,
          town: $town,
        """);
  }
}

class MedicineFilterPageView
    extends WidgetView<MedicineFilterPage, MedicineFilterPageController> {
  MedicineFilterPageView(MedicineFilterPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final filters = context.watch<ExchangesNotifier>().filters['medicines'];
    return SCModal(
      title: context.translate('filter'),
      children: [
        SizedBox(height: 20),
        SCTextField(
          label: context.translate('medicine_name'),
          hintText: "########",
          controller: state.titleController,
        ),
        SizedBox(height: 10),
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
          initial: filters != null && filters['wilaya'] != null
              ? Option<Wilaya>(
                  value: filters['wilaya'],
                  text: filters['wilaya'].name,
                )
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
          initial: filters != null && filters['town'] != null
              ? Option<Town>(
                  value: filters['town'],
                  text: filters['town'].name,
                )
              : null,
          options: context
              .watch<LocationsNotifier>()
              .wilayas
              .first
              .communes
              .map((town) => Option(text: town.nom, value: town))
              .toList(),
        ),
        SizedBox(height: 10),
        SCTextField(
          label: context.translate('dosage'),
          hintText: "########",
          controller: state.dosageController,
        ),
        SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            state.filter();
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
