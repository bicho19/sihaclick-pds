import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar-bottom-sheet.dart';
import 'package:sihaclik/elements/basics/sc-text-field.dart';

import 'package:sihaclik/helpers/sc-localization.dart';

class CreateReminderMedicine extends StatefulWidget {
  final String path;
  CreateReminderMedicine({this.path});

  @override
  _CreateReminderMedicineState createState() => _CreateReminderMedicineState();
}

class _CreateReminderMedicineState extends State<CreateReminderMedicine> {
  static final medicineNameController = TextEditingController();
  static final medicineDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _pureHeight = MediaQuery.of(context).size.height -
        20 -
        MediaQuery.of(context).padding.bottom;
    return Container(
      height: _pureHeight,
      child: CustomScrollView(
        slivers: [
          SCAppBarBottomSheet(
            title: context.translate('add_a_medicine'),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // SizedBox(height: 20),
                if (widget.path != null)
                  Container(
                    color: Theme.of(context).colorScheme.onSurface,
                    child: Image.file(
                      File(widget.path),
                      fit: BoxFit.contain,
                      height: 150,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      SCTextField(
                        controller: medicineNameController,
                        label: SCLocalizations.of(context)
                            .translate('medicine_name'),
                        hintText: "########",
                      ),
                      SizedBox(height: 10),
                      SCTextField(
                        controller: medicineDescriptionController,
                        label: SCLocalizations.of(context)
                            .translate('medicine_description'),
                        hintText: "########",
                      ),
                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          // if (medicineNameController.text.isNotEmpty &&
                          //     medicineDescriptionController.text.isNotEmpty) {
                          //   Navigator.of(context).pop(
                          //     Medicine(
                          //       title: medicineNameController.text,
                          //       subtitle: medicineDescriptionController.text,
                          //       source: widget.path,
                          //     ),
                          //   );
                          // }
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
                                SCLocalizations.of(context)
                                    .translate('confirm'),
                                style:
                                    Theme.of(context).textTheme.button.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                              ),
                              Spacer(),
                              Icon(Icons.chevron_right,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
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
          ),
        ],
      ),
    );
  }
}
