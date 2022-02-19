import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, required this.cardName}) : super(key: key);

  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blueGrey,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Order tapped.');
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