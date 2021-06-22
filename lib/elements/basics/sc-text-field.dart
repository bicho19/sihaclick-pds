import 'package:flutter/material.dart';

class SCTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Color color;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final bool showErrorMsg;
  final bool autoValidate;
  final TextInputType inputType;

  const SCTextField({
    @required this.label,
    @required this.hintText,
    this.color,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.autoValidate,
    this.onSaved,
    this.showErrorMsg = true,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: color ?? Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 4),
        Container(
          child: TextFormField(
            controller: controller,
            validator: validator,
            scrollPadding: EdgeInsets.zero,
            obscureText: obscureText,
            autovalidate: autoValidate ?? false,
            keyboardType: inputType ?? TextInputType.text,
            onSaved: onSaved,
            decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintStyle:
                    Theme.of(context).inputDecorationTheme.hintStyle.copyWith(
                          color: color?.withOpacity(0.5) ??
                              Theme.of(context)
                                  .colorScheme
                                  .primaryVariant
                                  .withOpacity(0.5),
                        ),
                errorMaxLines: 1,
                //Hide the error message, if you want to show it change it
                errorStyle: TextStyle(
                  height: double.minPositive,
                )),
          ),
        ),
      ],
    );
  }
}

class SCTextFieldLight extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final bool autoValidate;
  final FormFieldSetter<String> onSaved;
  final TextInputType inputType;
  final bool labelEnabled;
  final int maxLength;

  const SCTextFieldLight({
    @required this.label,
    @required this.hintText,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.autoValidate,
    this.onSaved,
    this.inputType,
    this.labelEnabled = true,
    this.maxLength = 9223372036854775807,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelEnabled)
          Text(
            label,
            style: Theme
                .of(context)
                .textTheme
                .subtitle1
                .copyWith(
              color: Theme
                  .of(context)
                  .colorScheme
                  .secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (labelEnabled) SizedBox(height: 4),
        Container(
          //height: ,
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .colorScheme
                .secondary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextFormField(
            scrollPadding: EdgeInsets.zero,
            validator: validator,
            controller: controller,
            autovalidate: autoValidate ?? false,
            onSaved: onSaved,
            keyboardType: inputType ?? TextInputType.text,
            maxLength: maxLength,
            style: TextStyle(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primaryVariant,
            ),
            obscureText: obscureText,
            decoration: InputDecoration(
                hintText: hintText,
                counterText: "",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                errorMaxLines: 1,
                //Hide the error message, if you want to show it change it
                errorStyle: TextStyle(
                  height: double.minPositive,
                )),
          ),
        ),
      ],
    );
  }
}
