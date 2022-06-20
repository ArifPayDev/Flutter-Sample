import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/checkout_fail/checkout_error_screen.dart';
import 'package:shop_app/screens/checkout_success/checkout_success_screen.dart';
import 'package:shop_app/service/payment.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text:
                            "\$${demoCarts.map((e) => e.product.price).toList().reduce((value, element) => value + element)}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () async {
                      try {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  width: 50,
                                  height: 50,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            });
                        PaymentService paymentService = new PaymentService();
                        var session = await paymentService.pay();
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) => WebView(
                                initialUrl: session.paymentUrl,
                                navigationDelegate:
                                    (NavigationRequest request) {
                                  final uri = Uri.parse(request.url);
                                  print(uri);
                                  if (request.url.contains("success")) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamed(
                                        CheckoutSuccessScreen.routeName);
                                  }
                                  if (request.url.contains("error")) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamed(
                                        CheckoutFailScreen.routeName);
                                  }
                                  if (request.url.contains("cancle")) {
                                    Navigator.of(context).pop();
                                  }

                                  return NavigationDecision.navigate;
                                },
                                javascriptMode: JavascriptMode.unrestricted));
                      } catch (e) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                child: Container(child: Text("Error: $e"))));
                        rethrow;
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
