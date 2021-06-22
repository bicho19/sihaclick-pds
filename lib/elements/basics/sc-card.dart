import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/hashed.dart';

class SCCard extends StatelessWidget {
  final String title;
  final String iconName;
  final void Function() setPage;
  const SCCard({
    this.title,
    this.iconName,
    this.setPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setPage(),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/$iconName.png",
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
