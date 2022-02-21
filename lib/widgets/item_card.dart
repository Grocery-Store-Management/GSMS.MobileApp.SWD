import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator ItemCard - COMPONENT

    return SizedBox(
      height: 210,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("data"),
              ],
            ),
            const Divider(
              thickness: 1.0,
            ),
            ListTile(
              title: const Text(
                '(408) 555-1212',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: const Text('costa@example.com'),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
