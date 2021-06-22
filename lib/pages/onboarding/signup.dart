import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-text-field.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/sizing.dart';
import 'package:sihaclik/config.dart';
import 'package:sihaclik/store/models/user.dart';
import 'package:sihaclik/store/services/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  final void Function() setPage;

  SignupPage({this.setPage});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey _parentKey = GlobalKey();
  final GlobalKey _childKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double remaining = 0;
  bool accept = false;
  bool autoValidateFields = false;
  AuthStateProvider _authStateProvider;
  User currentUser = User();
  String passwordValue;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final rm = (Sizing.remaining(
              parentKey: _parentKey,
              childKey: _childKey,
              context: context,
            ) -
            40);
        remaining = rm > 0 ? rm : 0;
        setState(() {});
        _authStateProvider = context.read<AuthStateProvider>();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFA7E4EB),
            Color(0xFF08B3C5),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          key: _parentKey,
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                // padding: EdgeInsets.veri(20),
                children: [
                  Column(
                    key: _childKey,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          context.translate('signup'),
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .secondary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20),
                            SCTextFieldLight(
                              label: SCLocalizations.of(context)
                                  .translate('first_name'),
                              hintText: "Mohamed",
                              autoValidate: autoValidateFields,
                              validator: (value) {
                                if (value.isEmpty || value.length < 3) {
                                  return '';
                                } else
                                  return null;
                              },
                              onSaved: (value) {
                                currentUser = currentUser.copyWith(name: value);
                              },
                            ),
                            SizedBox(height: 10),
                            SCTextFieldLight(
                              label: SCLocalizations.of(context)
                                  .translate('last_name'),
                              hintText: "Achouri",
                              validator: (value) {
                                if (value.isEmpty || value.length < 3)
                                  return "";
                                return null;
                              },
                              autoValidate: autoValidateFields,
                              onSaved: (value) {
                                currentUser =
                                    currentUser.copyWith(lastname: value);
                              },
                            ),
                            SizedBox(height: 10),
                            SCTextFieldLight(
                              label: context.translate('email'),
                              hintText: "email@email.com",
                              autoValidate: autoValidateFields,
                              inputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty ||
                                    !Config.EMAIL_REGEXP.hasMatch(value))
                                  return "";
                                return null;
                              },
                              onSaved: (value) =>
                              currentUser = currentUser.copyWith(email: value),
                            ),
                            SizedBox(height: 10),
                            SCTextFieldLight(
                              label: SCLocalizations.of(context)
                                  .translate('password'),
                              hintText: "password",
                              obscureText: true,
                              autoValidate: autoValidateFields,
                              validator: (value) {
                                passwordValue = value;
                                if (value.isEmpty || value.length < 6)
                                  return "";
                                return null;
                              },
                              onSaved: (value) {
                                currentUser =
                                    currentUser.copyWith(password: value);
                              },
                            ),
                            SizedBox(height: 10),
                            SCTextFieldLight(
                              label: SCLocalizations.of(context)
                                  .translate('confirm_password'),
                              hintText: "password confirmation",
                              obscureText: true,
                              autoValidate: autoValidateFields,
                              validator: (value) {
                                if (value.isEmpty || value.length < 6 ||
                                    passwordValue != value)
                                  return "";
                                return null;
                              },
                              onSaved: (value) =>
                              currentUser =
                                  currentUser.copyWith(confirm: value),
                            ),
                            SizedBox(height: 10),
                            SCTextFieldLight(
                              label: SCLocalizations.of(context)
                                  .translate('phone_number'),
                              hintText: "0550 00 00 00",
                              autoValidate: autoValidateFields,
                              inputType: TextInputType.phone,
                              maxLength: 10,
                              validator: (value) {
                                if (value.length < 10)
                                  return "";
                                return null;
                              },
                              onSaved: (value) =>
                              currentUser = currentUser.copyWith(phone: value),
                            ),
                            SizedBox(height: 10),
                            //TODO: fix birthday not saved
                            Text(
                              SCLocalizations.of(context)
                                  .translate('date_of_birth'),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                color:
                                Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: SCTextFieldLight(
                                      labelEnabled: false,
                                      label: null,
                                      hintText: "DD",
                                      autoValidate: autoValidateFields,
                                      inputType: TextInputType.number,
                                      maxLength: 2,
                                      validator: (value) {
                                        if (value.isEmpty ||
                                            int.parse(value) > 31) return "";
                                        return null;
                                      },
                                    )
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                    flex: 2,
                                    child: SCTextFieldLight(
                                      labelEnabled: false,
                                      label: null,
                                      hintText: "MM",
                                      autoValidate: autoValidateFields,
                                      inputType: TextInputType.number,
                                      maxLength: 2,
                                      validator: (value) {
                                        //Check if the month value isn't empty or above 12
                                        if (value.isEmpty ||
                                            int.parse(value) > 12) return "";
                                        return null;
                                      },
                                    )
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: SCTextFieldLight(
                                    labelEnabled: false,
                                    label: null,
                                    hintText: "YYYY",
                                    autoValidate: autoValidateFields,
                                    inputType: TextInputType.number,
                                    maxLength: 4,
                                    validator: (value) {
                                      //Check if the year is after 1930 and before current year
                                      if (value.isEmpty ||
                                          int.parse(value) < 1930 ||
                                          int.parse(value) > DateTime
                                              .now()
                                              .year)
                                        return "";
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     accept = !accept;
                      //     setState(() {});
                      //   },
                      //   child: Container(
                      //     color: Colors.transparent,
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 8, vertical: 4),
                      //     child: Row(
                      //       children: [
                      //         Checkbox(
                      //           activeColor:
                      //               Theme.of(context).colorScheme.primaryVariant,
                      //           value: accept,
                      //           onChanged: (_) {
                      //             accept = !accept;
                      //             setState(() {});
                      //           },
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //              SCLocalizations.of(context)
                      //                       .translate('i_have_read_and_accept') +
                      //                   " ",
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .caption
                      //                   .copyWith(
                      //                     color: Theme.of(context)
                      //                         .scaffoldBackgroundColor,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //             ),
                      //             GestureDetector(
                      //               onTap: () {},
                      //               child: Text(
                      //                SCLocalizations.of(context)
                      //                         .translate('conditions_of_use') +
                      //                     ".",
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .caption
                      //                     .copyWith(
                      //                       color: Theme.of(context)
                      //                           .scaffoldBackgroundColor,
                      //                       fontWeight: FontWeight.bold,
                      //                       decoration: TextDecoration.underline,
                      //                     ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: remaining,
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () => _saveUserData(),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color:
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .primaryVariant,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Theme
                                      .of(context)
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
                                  context.translate('signup'),
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .button
                                      .copyWith(
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 25,
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Theme
                                        .of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveUserData() {
    //check Fields,
    if (_formKey.currentState.validate()) {
      //form is valid
      _formKey.currentState.save();
      print("Form has been saved");
      print(currentUser.toJson());
      print("AuthState user");
      _authStateProvider.setUserBasicInformation(currentUser);
      print(_authStateProvider.currentUser.toJson());

      //then push to blood
      Navigator.of(context).pushNamed("/blood");
    } else {
      debugPrint("Error validation form");
      setState(() {
        autoValidateFields = true;
      });
    }
  }
}
