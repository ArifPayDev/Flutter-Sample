import 'package:flutter/material.dart';

import 'components/body.dart';

class CheckoutFailScreen extends StatelessWidget {
  static String routeName = "/checkout_failed";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Checkout Failed"),
      ),
      body: Body(),
    );
  }
}
