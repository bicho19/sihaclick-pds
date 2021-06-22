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

class MedicineCreatePage extends StatefulWidget {
  @override
  _MedicineCreatePageController createState() =>
      _MedicineCreatePageController();
}

class _MedicineCreatePageController extends State<MedicineCreatePage> {
  @override
  Widget build(BuildContext context) => _MedicineCreatePageView(this);

  TextEditingController titleController = TextEditingController();
  TextEditingController moleculeController = TextEditingController();
  TextEditingController ddController = TextEditingController();
  TextEditingController mmController = TextEditingController();
  TextEditingController yyyyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
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
  // String image;

  void create() {
    context.read<ExchangesNotifier>().createMedicine(
          title: titleController.text,
          description: "",
          image: null,
          date: DateTime.now(),
          molecule: moleculeController.text,
          dosage: dosageController.text,
          experation: DateTime(
            int.parse(yyyyController.text),
            int.parse(mmController.text),
            int.parse(ddController.text),
          ),
          wilaya: wilaya,
          town: town,
          phone: phoneController.text,
        );
    Navigator.of(context).pop();
  }
}

class _MedicineCreatePageView
    extends WidgetView<MedicineCreatePage, _MedicineCreatePageController> {
  _MedicineCreatePageView(_MedicineCreatePageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return SCModal(
      title: context.translate('add_a_medicine'),
      children: [
        SizedBox(height: 10),
        SizedBox(height: 20),
        SCTextField(
          label: context.translate('medicine_name'),
          hintText: "",
          controller: state.titleController,
        ),
        SizedBox(height: 10),
        SCTextField(
          label: context.translate('molecule'),
          hintText: "",
          controller: state.moleculeController,
        ),
        SizedBox(height: 10),
        SCTextField(
          label: context.translate('dosage'),
          hintText: "",
          controller: state.dosageController,
        ),
        SizedBox(height: 10),
        Text(
          context.translate('expiration_date'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(hintText: "DD"),
                controller: state.ddController,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(hintText: "MM"),
                controller: state.mmController,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: TextField(
                decoration: InputDecoration(hintText: "YYYY"),
                controller: state.yyyyController,
              ),
            ),
          ],
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
        SizedBox(height: 10),
        Text(
          context.translate('add_a_picture'),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 4),
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.background,
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 1.0,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  context.translate('take_a_photo_of_the_medicine'),
                  style:
                      Theme.of(context).inputDecorationTheme.hintStyle.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryVariant
                                .withOpacity(0.5),
                          ),
                ),
              ),
              Icon(Icons.camera,
                  color: Theme.of(context).colorScheme.primaryVariant),
            ],
          ),
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
