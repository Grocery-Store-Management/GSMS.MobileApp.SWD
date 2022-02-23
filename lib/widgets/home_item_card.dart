import 'package:flutter/material.dart';

class HomeItemCard extends StatefulWidget {
  const HomeItemCard(
      {Key? key,
      required this.cardIcon,
      required this.cardName,
      required this.routeName,
      required this.amount,})
      : super(key: key);

  final Icon cardIcon;
  final String cardName;
  final String routeName;
  final int amount;

  @override
  State<HomeItemCard> createState() => _HomeItemCardState();
}

class _HomeItemCardState extends State<HomeItemCard> {
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
              Text(
                widget.amount.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 18),
              ),
            ],
          )),
    );
  }
}
