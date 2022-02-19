import 'package:flutter/material.dart';
import 'package:gsms_mobileapp_swd/widgets/menu_card.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 3,
      children: const <Widget>[
        MenuCard(cardName: 'Order',),
        MenuCard(cardName: 'Product',),
        MenuCard(cardName: 'Brand',),
        MenuCard(cardName: 'Employee',),
        MenuCard(cardName: 'Customer',),
        MenuCard(cardName: 'Shop',),
      ],
    );
  }
}