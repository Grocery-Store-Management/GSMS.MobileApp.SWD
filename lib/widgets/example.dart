import 'package:flutter/material.dart';
import 'dart:math' as math;

class Itemcard1Widget extends StatefulWidget {
  @override
  _Itemcard1WidgetState createState() => _Itemcard1WidgetState();
}

class _Itemcard1WidgetState extends State<Itemcard1Widget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Itemcard1Widget - COMPONENT

    return SizedBox(
        width: 330,
        height: 160,
        child: Stack(children: <Widget>[
          Positioned(
              top: 80,
              left: 0,
              child: SizedBox(
                  width: 144,
                  height: 24,
                  child: Stack(children: const <Widget>[
                    Positioned(
                        top: 0,
                        left: 24,
                        child: Text(
                          'Pay amount',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                  ]))),
          Positioned(
              top: 46,
              left: 0,
              child: SizedBox(
                  width: 144,
                  height: 24,
                  child: Stack(children: const <Widget>[
                    Positioned(
                        top: 0,
                        left: 24,
                        child: Text(
                          'Customer’s name',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                  ]))),
          Positioned(
              top: 114,
              left: 0,
              child: SizedBox(
                  width: 144,
                  height: 24,
                  child: Stack(children: const <Widget>[
                    Positioned(
                        top: 0,
                        left: 24,
                        child: Text(
                          'Quantity',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                  ]))),
          Positioned(
              top: 114,
              left: 195,
              child: SizedBox(
                  width: 103,
                  height: 26,
                  child: Stack(children: const <Widget>[
                    Positioned(
                        top: 2,
                        left: 29,
                        child: Text(
                          'Order date',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                  ]))),
          Positioned(
              top: 46,
              left: 192,
              child: SizedBox(
                  width: 137,
                  height: 24,
                  child: Stack(children: const <Widget>[
                    Positioned(
                        top: 0,
                        left: 32,
                        child: Text(
                          'Phone number',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                  ]))),
          Positioned(
              top: 8,
              left: 226,
              child: SizedBox(
                  width: 80,
                  height: 20,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 80,
                            height: 20,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.20000000298023224),
                                    offset: Offset(0, 4),
                                    blurRadius: 30)
                              ],
                              color: Color.fromRGBO(58, 183, 78, 1),
                            ))),
                    const Positioned(
                        top: 0,
                        left: 19,
                        child: Text(
                          'Status',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                  ]))),
          const Positioned(
              top: 8,
              left: 8,
              child: Text(
                'Order’s ID',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Mulish',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              )),
          Positioned(
              top: 36,
              left: 0,
              child: Transform.rotate(
                angle: -0.17362304712350585 * (math.pi / 180),
                child:
                    const Divider(color: Color.fromRGBO(50, 50, 50, 1), thickness: 1),
              )),
        ]));
  }
}
