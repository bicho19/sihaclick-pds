import 'package:flutter/material.dart';

class SCLoadingDialog extends StatelessWidget {
  final String subtitle;

  const SCLoadingDialog({Key key, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ), //this right here
      child: Container(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 18,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
