// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shop_app/service/arifpay.dart';
import 'package:shop_app/service/exception/arifpayexception.dart';

class CheckoutService {
  final Dio _dio;
  final ArifPayOption option;

  CheckoutService(this._dio, this.option);

  Future<ArifpayCheckoutReponse> create(
      List<ArifpayCheckoutItem> arifpayCheckoutItems) async {
    try {
      ArifpayCheckoutRequest request = new ArifpayCheckoutRequest(
          items: arifpayCheckoutItems,
          cancelUrl: this.option.cancleURL,
          errorUrl: option.errorURL,
          successUrl: option.successURL);
      Response response = await _dio.post("/api/create-checkout-session",
          data: request.toMap());
      print(response.data);
      return ArifpayCheckoutReponse.fromMap(response.data!["data"]);
    } on DioError catch (e) {
      print(e);
      if (e.response == null ||
          e.response?.data == null ||
          e.response?.statusCode == null) rethrow;

      throw ArifpayException(e.response?.data["msg"], e.response!.statusCode!);
    }
  }
}

class ArifpayCheckoutReponse {
  final String sessionId;
  final String paymentUrl;
  final String cancelUrl;
  final double totalAmount;
  ArifpayCheckoutReponse({
    required this.sessionId,
    required this.paymentUrl,
    required this.cancelUrl,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sessionId': sessionId,
      'paymentUrl': paymentUrl,
      'cancelUrl': cancelUrl,
      'totalAmount': totalAmount,
    };
  }

  factory ArifpayCheckoutReponse.fromMap(Map<String, dynamic> map) {
    return ArifpayCheckoutReponse(
      sessionId: map['sessionId'] as String,
      paymentUrl: map['paymentUrl'] as String,
      cancelUrl: map['cancelUrl'] as String,
      totalAmount: map['totalAmount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArifpayCheckoutReponse.fromJson(String source) =>
      ArifpayCheckoutReponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class ArifpayCheckoutRequest {
  final String cancelUrl;
  final String errorUrl;
  final String successUrl;
  List<ArifpayCheckoutItem> items;

  ArifpayCheckoutRequest(
      {required this.cancelUrl,
      required this.errorUrl,
      required this.successUrl,
      required this.items});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorUrl': errorUrl,
      'successUrl': successUrl,
      'cancelUrl': cancelUrl,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory ArifpayCheckoutRequest.fromMap(Map<String, dynamic> map) {
    return ArifpayCheckoutRequest(
      cancelUrl: map['cancelUrl'] as String,
      errorUrl: map['errorUrl'] as String,
      successUrl: map['successUrl'] as String,
      items: List<ArifpayCheckoutItem>.from(
        (map['items'] as List<int>).map<ArifpayCheckoutItem>(
          (x) => ArifpayCheckoutItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ArifpayCheckoutRequest.fromJson(String source) =>
      ArifpayCheckoutRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArifpayCheckoutRequest(cancelUrl: $cancelUrl, errorUrl: $errorUrl, successUrl: $successUrl, items: $items)';
  }
}

class ArifpayCheckoutItem {
  final String name;
  final double price;
  final int quantity;
  final String? description;
  final String? image;

  ArifpayCheckoutItem(
      {required this.name,
      required this.price,
      required this.quantity,
      required this.description,
      required this.image});

  ArifpayCheckoutItem copyWith({
    String? name,
    double? price,
    int? quantity,
    String? description,
    String? image,
  }) {
    return ArifpayCheckoutItem(
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'image': image,
    };
  }

  factory ArifpayCheckoutItem.fromMap(Map<String, dynamic> map) {
    return ArifpayCheckoutItem(
      name: map['name'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArifpayCheckoutItem.fromJson(String source) =>
      ArifpayCheckoutItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ArifpayCheckoutItem(price: $price, quantity: $quantity, description: $description, image: $image)';
  }
}
