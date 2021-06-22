import 'package:flutter/material.dart';

class SCDialog extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final String subtitle;
  final String imageName;
  final String label;
  SCDialog({
    @required this.title,
    @required this.subtitle,
    @required this.imageName,
    @required this.label,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ), //this right here
      child: Container(
        height: 480,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/$imageName.png",
                fit: BoxFit.contain,
                height: 222,
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: onPressed,
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
                        label,
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
          ),
        ),
      ),
    );
  }
}
