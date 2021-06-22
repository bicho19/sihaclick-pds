import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-raised-button.dart';
import 'package:sihaclik/elements/basics/sc-text-field.dart';
import 'package:sihaclik/elements/controls/sc-dialog.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/appointments/Appointments.dart';

class AppointmentSubmitionPage extends StatelessWidget {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SCAppBar(
          title: context.translate('make_an_appointment'),
          clear: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    SCTextField(
                      label: context.translate('last_name'),
                      hintText: "Charif",
                    ),
                    SizedBox(height: 10),
                    SCTextField(
                      label: context.translate('first_name'),
                      hintText: "Mohamed",
                    ),
                    SizedBox(height: 10),
                    SCTextField(
                      label: context.translate('phone_number'),
                      hintText: "+213",
                    ),
                    SizedBox(height: 10),
                    Text(
                      context.translate('date_of_birth'),
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
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            decoration: InputDecoration(hintText: "MM"),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(hintText: "YYYY"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${context.translate('appointment_for')} :",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 4),
                    SCDropdown(
                      soft: true,
                      label: SCLocalizations.of(context)
                          .translate('visit_control_care'),
                      options: ['visit', 'control', 'care']
                          .map(
                            (e) => Option(value: e, text: context.translate(e)),
                          )
                          .toList(),
                      callback: () async {
                        await Future.delayed(Duration(milliseconds: 200));
                        controller.animateTo(
                          controller.position.maxScrollExtent,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      context.translate('reasons'),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Theme.of(context).colorScheme.primaryVariant,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 4),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: SCLocalizations.of(context)
                            .translate('add_a_description'),
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              SCRaisedButton(
                title: context.translate('confirm'),
                withIcon: true,
                margin: EdgeInsets.symmetric(horizontal: 20),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SCDialog(
                          title: SCLocalizations.of(context)
                              .translate('appointment_alert_title'),
                          subtitle: SCLocalizations.of(context)
                              .translate('appointment_alert_content'),
                          imageName: "dialog-appointment",
                          label: context.translate('next'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      });
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => AppointmentsPage(),
                    ),
                  );
                },
              ),
              // // SizedBottomSpacer(),
            ],
          ),
        ),
      ],
    );
  }
}
