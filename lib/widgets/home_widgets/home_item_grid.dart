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
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 5.0),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 3,
      children: const <Widget>[
        ItemCard(
          cardIcon: Icon(Icons.shopping_cart),
          cardName: 'Order',
          route: '/order_screen',
        ),
        ItemCard(
          cardIcon: Icon(Icons.fastfood),
          cardName: 'Product',
          route: '/product_screen',
        ),
        ItemCard(
          cardIcon: Icon(Icons.shop),
          cardName: 'Brand',
          route: '/brand_screen',
        ),
        ItemCard(
          cardIcon: Icon(Icons.store),
          cardName: 'Store',
          route: '/store_screen',
        ),
        ItemCard(
          cardIcon: Icon(Icons.note),
          cardName: 'Receipt',
          route: '/receipt_screen',
        ),
        ItemCard(
          cardIcon: Icon(Icons.layers),
          cardName: 'Category',
          route: '/category_screen',
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
    required this.route,
  }) : super(key: key);

  final Icon cardIcon;
  final String cardName;
  final String route;

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
        splashColor: Colors.blue.withAlpha(50),
        onTap: () {
          Navigator.pushNamed(context, widget.route);
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
