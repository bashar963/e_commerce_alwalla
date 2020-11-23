import 'dart:convert';

class ShippingMethodResponse {
  ShippingMethodResponse({
    this.carrierCode,
    this.methodCode,
    this.carrierTitle,
    this.methodTitle,
    this.amount,
    this.baseAmount,
    this.available,
    this.errorMessage,
    this.priceExclTax,
    this.priceInclTax,
  });

  bool isSelected = false;
  String carrierCode;
  String methodCode;
  String carrierTitle;
  String methodTitle;
  dynamic amount;
  dynamic baseAmount;
  bool available;
  String errorMessage;
  dynamic priceExclTax;
  dynamic priceInclTax;

  factory ShippingMethodResponse.fromRawJson(String str) =>
      ShippingMethodResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingMethodResponse.fromJson(Map<String, dynamic> json) =>
      ShippingMethodResponse(
        carrierCode: json["carrier_code"],
        methodCode: json["method_code"],
        carrierTitle: json["carrier_title"],
        methodTitle: json["method_title"],
        amount: json["amount"],
        baseAmount: json["base_amount"],
        available: json["available"],
        errorMessage: json["error_message"],
        priceExclTax: json["price_excl_tax"],
        priceInclTax: json["price_incl_tax"],
      );

  Map<String, dynamic> toJson() => {
        "carrier_code": carrierCode,
        "method_code": methodCode,
        "carrier_title": carrierTitle,
        "method_title": methodTitle,
        "amount": amount,
        "base_amount": baseAmount,
        "available": available,
        "error_message": errorMessage,
        "price_excl_tax": priceExclTax,
        "price_incl_tax": priceInclTax,
      };
}
