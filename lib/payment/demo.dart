import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThePaymentDemo extends StatefulWidget {
  ThePaymentDemo({Key key}) : super(key: key);

  @override
  _ThePaymentDemoState createState() => _ThePaymentDemoState();
}

class _ThePaymentDemoState extends State<ThePaymentDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                CupertinoButton(child: Text("PAY BIATCH"), onPressed: () {})));
  }
}
