import 'package:flutter/material.dart';
import 'package:sihaclik/config.dart';
import 'package:sihaclik/elements/basics/sc-text-field.dart';
import 'package:sihaclik/elements/controls/sc_loading_dialog.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/sizing.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/services/auth_provider.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey _parentKey = GlobalKey();
  final GlobalKey _childKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double remaining = 0;
  String _email, _password;
  bool autoValidateFields = false;
  AuthStateProvider _authStateProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        remaining = Sizing.remaining(
              parentKey: _parentKey,
              childKey: _childKey,
              context: context,
            ) -
            40;
        setState(() {});
        _authStateProvider = context.read<AuthStateProvider>();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: _parentKey,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Column(
                  key: _childKey,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: remaining / 3 * 2,
                    ),
                    Text(
                      context.translate('signin'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5
                          .copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primaryVariant,
                      ),
                    ),
                    SizedBox(height: 20),
                    SCTextField(
                      label: context.translate('email'),
                      hintText: "email@email.com",
                      inputType: TextInputType.emailAddress,
                      autoValidate: autoValidateFields,
                      validator: (value) {
                        if (value.isEmpty ||
                            !Config.EMAIL_REGEXP.hasMatch(value))
                          return "";
                        return null;
                      },
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 10),
                    SCTextField(
                      label: context.translate('password'),
                      hintText: "password",
                      obscureText: true,
                      autoValidate: autoValidateFields,
                      validator: (value) {
                        if (value.isEmpty || value.length < 6) return "";
                        return null;
                      },
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      padding: EdgeInsets.all(0),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          SCLocalizations.of(context)
                              .translate('forgot_your_password'),
                          style: Theme
                              .of(context)
                              .textTheme
                              .button
                              .copyWith(
                            decoration: TextDecoration.underline,
                            color:
                            Theme
                                .of(context)
                                .colorScheme
                                .primaryVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(SCLocalizations.of(context)
                            .translate('or_login_with') +
                            " :"),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/icons/google.png",
                            width: 35,
                            height: 35,
                            fit: BoxFit.contain,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/icons/facebook.png",
                            width: 35,
                            height: 35,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: remaining / 3,
                    ),
                    GestureDetector(
                      onTap: () => _checkAndLogin(),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
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
                            Text(
                              context.translate('signin'),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                color:
                                Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _checkAndLogin() async {
    if (_formKey.currentState.validate()) {
      //form is valid
      _formKey.currentState.save();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              SCLoadingDialog(
                subtitle: "Loading",
              ));
      var results = await _authStateProvider.loginUser(
          email: _email, password: _password);
      debugPrint(results.toString());
      if (results) {
        Navigator.of(context).pop();
        //Remove any previous route, and go to the main screen
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/main", (route) => false);
      } else {
        Navigator.of(context).pop();
      }
    } else {
      debugPrint("Error validation form");
      setState(() {
        autoValidateFields = true;
      });
    }
  }
}
