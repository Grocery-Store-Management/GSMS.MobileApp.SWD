import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, required this.cardName, required this.routeName}) : super(key: key);

  final String cardName;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blueGrey,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Text(
          cardName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}