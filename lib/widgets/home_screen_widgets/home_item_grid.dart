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
          cardIcon: Icon(Icons.shopping_cart),
          cardName: 'Order',
          routeName: '/order_screen',
        ),
        ItemCard(
          cardIcon: Icon(Icons.fastfood),
          cardName: 'Product',
          routeName: '/',
        ),
        ItemCard(
          cardIcon: Icon(Icons.shop),
          cardName: 'Brand',
          routeName: '/',
        ),
        ItemCard(
          cardIcon: Icon(Icons.store),
          cardName: 'Store',
          routeName: '/',
        ),
        ItemCard(
          cardIcon: Icon(Icons.note),
          cardName: 'Receipt',
          routeName: '/',
        ),
        ItemCard(
          cardIcon: Icon(Icons.layers),
          cardName: 'Category',
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
