import 'package:flutter/material.dart';

import 'components/body.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  static String routeName = "/checkout_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Checkout Success"),
      ),
      body: Body(),
    );
  }
}
