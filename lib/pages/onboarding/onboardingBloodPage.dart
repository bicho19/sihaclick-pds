import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:sihaclik/elements/controls/sc_loading_dialog.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/sizing.dart';
import 'package:sihaclik/pages/exchange/blood/create.dart';
import 'package:sihaclik/store/abstracts/widget-view.dart';
import 'package:sihaclik/store/models/address.dart';
import 'package:sihaclik/store/models/chaab.dart';
import 'package:sihaclik/store/models/town.dart';
import 'package:sihaclik/store/models/wilaya.dart';
import 'package:sihaclik/store/notifiers/locations.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/services/auth_provider.dart';

class OnboardingBloodPage extends StatefulWidget {
  final ScrollController controller = ScrollController();
  final void Function() setPage;

  OnboardingBloodPage({this.setPage});

  @override
  _OnboardingBloodPageController createState() =>
      _OnboardingBloodPageController();
}

class _OnboardingBloodPageController extends State<OnboardingBloodPage> {
  final GlobalKey _parentKey = GlobalKey();
  final GlobalKey _childKey = GlobalKey();

  double remaining = 0;
  bool accept = false;
  bool notifications = false;
  bool confirm = false;
  String bloodRhesus = "";
  String bloodGroup = "";

  Wilaya wilaya;
  Town _selectedTown;

  bool _isErrorVisible = false;

  AuthStateProvider _authStateProvider;

  @override
  Widget build(BuildContext context) => _OnboardingBloodPageView(this);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final rm = Sizing.remaining(
            parentKey: _parentKey, childKey: _childKey, context: context);
        remaining = max(206, rm);
        setState(() {});
      },
    );
    _selectedTown = Town(id: 0, nom: "", code_postal: "", wilaya_id: 0);
    _authStateProvider = context.read<AuthStateProvider>();
    super.initState();
  }

  void setWilaya(Option<dynamic> option) {
    this.wilaya = option.value;
    setState(() {});
  }

  void setTown(Option<dynamic> option) {
    this._selectedTown = option.value;
    setState(() {});
  }

  void toggleAccept() {
    accept = !accept;
    setState(() {});
  }

  void toggleNotifications() {
    notifications = !notifications;
    setState(() {});
  }

  void toggleConfirm() {
    confirm = !confirm;
    setState(() {});
  }
}

class _OnboardingBloodPageView
    extends WidgetView<OnboardingBloodPage, _OnboardingBloodPageController> {

  _OnboardingBloodPageView(_OnboardingBloodPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        key: state._parentKey,
        child: SafeArea(
          child: Container(
            child: ListView(
              controller: widget.controller,
              children: [
                Column(
                  key: state._childKey,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            SCLocalizations.of(context)
                                .translate('onboarding_blood_title'),
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            SCLocalizations.of(context)
                                .translate('onboarding_blood_subtitle'),
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
                                .translate('onboarding_blood_description'),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/images/onboarding-heart.png",
                      height: state.remaining,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            SCLocalizations.of(context)
                                .translate('blood_group'),
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          SizedBox(height: 4),
                          SCDropdown(
                            soft: true,
                            label: ['A', 'B', 'AB', 'O'].join(', '),
                            options: ['A', 'B', 'AB', 'O']
                                .map((e) => Option(text: e, value: e))
                                .toList(),
                            onChange: (option) {
                              //TODO : implement blood change
                              state.bloodGroup = option.text;
                              debugPrint(
                                  "BloodGroup change : ${state.bloodGroup}");
                            },
                          ),
                          SizedBox(height: 10),
                          BloodToggle(
                            initial: state.bloodRhesus,
                            onChange: (value) {
                              debugPrint("toogle $value");
                              state.setState(() {
                                state.bloodRhesus = value;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            context.translate('wilaya'),
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primaryVariant,
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
                                  (wilaya) =>
                                  Option<Wilaya>(
                                      text: wilaya.nom, value: wilaya),
                            )
                                .toList(),
                            callback: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              widget.controller.animateTo(
                                widget.controller.position.maxScrollExtent / 5,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            context.translate('town'),
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          SizedBox(height: 4),
                          SCDropdown<Town>(
                            soft: true,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primaryVariant,
                            label: "",
                            onChange: state.setTown,
                            options: state.wilaya?.communes
                                ?.map(
                                  (town) =>
                                  Option<Town>(
                                      text: town.nom, value: town),
                            )
                                ?.toList() ??
                                [],
                            callback: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              widget.controller.animateTo(
                                widget.controller.position.maxScrollExtent / 5,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: state.toggleAccept,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                              child: Checkbox(
                                activeColor: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                value: state.accept,
                                onChanged: (_) => state.toggleAccept(),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  SCLocalizations.of(context)
                                          .translate('i_have_read_and_accept') +
                                      " ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    SCLocalizations.of(context)
                                            .translate('conditions_of_use') +
                                        ".",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryVariant,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: state.toggleNotifications,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                              child: Checkbox(
                                activeColor: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                value: state.notifications,
                                onChanged: (_) => state.toggleNotifications(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                context.translate(
                                        'willing_to_recieve_notifications') +
                                    " ",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: state.toggleConfirm,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                              child: Checkbox(
                                activeColor: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                value: state.confirm,
                                onChanged: (_) => state.toggleConfirm(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                context.translate(
                                    'confirm_personal_information') +
                                    " ",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: state._isErrorVisible,
                        child: Column(
                          children: [
                            SizedBox(height: 8,),
                            Text("Error while signing up, please try again",
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,),
                          ],
                        )),
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () => _saveAndSubmitUserData(),
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 29),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
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
                              context.translate('confirm'),
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveAndSubmitUserData() async {
    //Check data before
    if (state.confirm &&
        state.accept &&
        state.bloodGroup.isNotEmpty &&
        state.bloodRhesus.isNotEmpty &&
        state.wilaya.nom.isNotEmpty &&
        state._selectedTown.nom.isNotEmpty) {
      //Data is good go ahead
      state._authStateProvider.setUserChaab(
        Chaab(
          blood_notification: state.notifications,
          language: true,
          address: Address(
            commune: Town(
              id: state._selectedTown.id,
              nom: "",
              code_postal: "",
              wilaya_id: 0,
            ),
          ),
        ),
      );
      state._authStateProvider.setBloodGroup(3);
      showDialog(
          context: state.context,
          barrierDismissible: false,
          builder: (context) => SCLoadingDialog(
                subtitle: "Loading",
              ));
      bool results = await state._authStateProvider.registerUser();
      debugPrint(" Results === " + results.toString());
      if (results) {
        Navigator.of(state.context).pop();
        //Remove any previous route, and go to the main screen
        Navigator.of(state.context)
            .pushNamedAndRemoveUntil("/main", (route) => false);
      } else {
        Navigator.of(state.context).pop();
        state.setState(() {
          state._isErrorVisible = true;
        });
      }
    } else {
      debugPrint("Error, Not all information are provided");
    }
  }
}
