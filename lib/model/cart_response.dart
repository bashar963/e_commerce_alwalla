// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

class CartResponse {
  CartResponse({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.isVirtual,
    this.items,
    this.itemsCount,
    this.itemsQty,
    this.origOrderId,
    this.currency,
    this.customerIsGuest,
    this.customerNoteNotify,
    this.customerTaxClassId,
    this.storeId,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;
  bool isVirtual;
  List<Item> items;
  int itemsCount;
  int itemsQty;
  int origOrderId;
  Currency currency;
  bool customerIsGuest;
  bool customerNoteNotify;
  int customerTaxClassId;
  int storeId;

  factory CartResponse.fromRawJson(String str) =>
      CartResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
        isVirtual: json["is_virtual"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        itemsCount: json["items_count"],
        itemsQty: json["items_qty"],
        origOrderId: json["orig_order_id"],
        currency: Currency.fromJson(json["currency"]),
        customerIsGuest: json["customer_is_guest"],
        customerNoteNotify: json["customer_note_notify"],
        customerTaxClassId: json["customer_tax_class_id"],
        storeId: json["store_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_active": isActive,
        "is_virtual": isVirtual,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "items_count": itemsCount,
        "items_qty": itemsQty,
        "orig_order_id": origOrderId,
        "currency": currency.toJson(),
        "customer_is_guest": customerIsGuest,
        "customer_note_notify": customerNoteNotify,
        "customer_tax_class_id": customerTaxClassId,
        "store_id": storeId,
      };
}

class Currency {
  Currency({
    this.globalCurrencyCode,
    this.baseCurrencyCode,
    this.storeCurrencyCode,
    this.quoteCurrencyCode,
    this.storeToBaseRate,
    this.storeToQuoteRate,
    this.baseToGlobalRate,
    this.baseToQuoteRate,
  });

  String globalCurrencyCode;
  String baseCurrencyCode;
  String storeCurrencyCode;
  String quoteCurrencyCode;
  int storeToBaseRate;
  int storeToQuoteRate;
  int baseToGlobalRate;
  int baseToQuoteRate;

  factory Currency.fromRawJson(String str) =>
      Currency.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        globalCurrencyCode: json["global_currency_code"],
        baseCurrencyCode: json["base_currency_code"],
        storeCurrencyCode: json["store_currency_code"],
        quoteCurrencyCode: json["quote_currency_code"],
        storeToBaseRate: json["store_to_base_rate"],
        storeToQuoteRate: json["store_to_quote_rate"],
        baseToGlobalRate: json["base_to_global_rate"],
        baseToQuoteRate: json["base_to_quote_rate"],
      );

  Map<String, dynamic> toJson() => {
        "global_currency_code": globalCurrencyCode,
        "base_currency_code": baseCurrencyCode,
        "store_currency_code": storeCurrencyCode,
        "quote_currency_code": quoteCurrencyCode,
        "store_to_base_rate": storeToBaseRate,
        "store_to_quote_rate": storeToQuoteRate,
        "base_to_global_rate": baseToGlobalRate,
        "base_to_quote_rate": baseToQuoteRate,
      };
}

class Item {
  Item({
    this.itemId,
    this.sku,
    this.qty,
    this.name,
    this.price,
    this.productType,
    this.quoteId,
  });

  int itemId;
  String sku;
  dynamic qty;
  String name;
  dynamic price;
  String productType;
  String quoteId;

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"],
        sku: json["sku"],
        qty: json["qty"],
        name: json["name"],
        price: json["price"],
        productType: json["product_type"],
        quoteId: json["quote_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "sku": sku,
        "qty": qty,
        "name": name,
        "price": price,
        "product_type": productType,
        "quote_id": quoteId,
      };
}
