import 'package:dio/dio.dart';
import 'package:shop_app/service/checkout.dart';

class Arifpay {
  late ArifPayOption arifPayOption;
  late CheckoutService checkout;
  static const String APIVERSION = "v0";
  // ignore: non_constant_identifier_names
  String BASE_URL = "https://sample.arifpay.net/$APIVERSION";

  late Dio _dio;
  static Arifpay? _instance;

  static Arifpay get instance {
    return _instance ??= Arifpay._();
  }

  Arifpay._();

  void init(ArifPayOption option) {
    arifPayOption = option;

    _dio = Dio(BaseOptions(baseUrl: BASE_URL));
    checkout = CheckoutService(_dio, option);
  }
}

class ArifPayOption {
  String successURL;
  String errorURL;
  String cancleURL;

  ArifPayOption(
      {required this.errorURL,
      required this.successURL,
      required this.cancleURL});
}
