import 'package:flutter/material.dart';

import './widgets/GridLayout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        title: const Text('GSM Admin'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: const <Widget>[
          GridCard(),
        ],
      ),
    );
  }
}


