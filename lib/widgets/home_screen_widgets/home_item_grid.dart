import 'package:flutter/material.dart';

class HomeItemGrid extends StatefulWidget {
  const HomeItemGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeItemGrid> createState() => _HomeItemGridState();
}

class _HomeItemGridState extends State<HomeItemGrid> {
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
        ItemCard(
          cardIcon: Icon(Icons.shopping_cart_outlined),
          cardName: 'Order',
          routeName: '/order_screen',
        ),
        ItemCard(
          cardIcon: Icon(Icons.fastfood_outlined),
          cardName: 'Product',
          routeName: '/',
        ),
        ItemCard(
          cardIcon: Icon(Icons.shop),
          cardName: 'Brand',
          routeName: '/',
        ),
        ItemCard(
          cardIcon: Icon(Icons.people_alt_outlined),
          cardName: 'Employee',
          routeName: '/',
        ),
        ItemCard(
          cardIcon: Icon(Icons.remove_shopping_cart_outlined),
          cardName: 'Sold out',
          routeName: '/',
        ),
        ItemCard(
          cardIcon: Icon(Icons.trending_down_outlined),
          cardName: 'Low in Stock',
          routeName: '/',
        ),
      ],
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key? key,
    required this.cardIcon,
    required this.cardName,
    required this.routeName,
  }) : super(key: key);

  final Icon cardIcon;
  final String cardName;
  final String routeName;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blueGrey,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.pushNamed(context, widget.routeName);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.cardIcon,
            Text(
              widget.cardName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
