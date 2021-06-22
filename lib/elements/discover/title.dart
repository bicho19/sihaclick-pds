import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sc-localization.dart';

class Title extends StatelessWidget {
  final String title;
  final void Function() more;
  const Title({Key key, @required this.title, this.more}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          if (more != null) ...[
            Expanded(
              child: Container(
                height: Theme.of(context).textTheme.headline6.fontSize,
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.all(0),
                  onPressed: more,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      context.translate('show_all'),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.caption.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
