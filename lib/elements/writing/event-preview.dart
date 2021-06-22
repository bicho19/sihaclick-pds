import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/store/models/event.dart';

class EventPreview extends StatelessWidget {
  final Event event;
  EventPreview({@required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            child: Image.asset(
              event.image,
              height: 185,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0, bottom: 8),
            child: Column(
              children: [
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/location.png",
                      width: 17,
                      height: 17,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        event.location,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/calendar.png",
                      width: 17,
                      height: 17,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        TimeFormat.format(context, event.date),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Spacer(),
              FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      context.translate('register'),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    SizedBox(width: 4),
                    Transform.rotate(
                      angle: Directionality.of(context) == TextDirection.rtl
                          ? 180 * pi / 180
                          : 0,
                      child: Image.asset("assets/icons/arrow-right.png"),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
            ],
          )
        ],
      ),
    );
  }
}
