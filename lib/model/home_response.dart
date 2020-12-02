// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:e_commerce_alwalla/model/products_response.dart';

class HomeResponse {
  HomeResponse({
    this.id,
    this.parentId,
    this.name,
    this.isActive,
    this.position,
    this.level,
    this.productCount,
    this.childrenData,
  });

  dynamic id;
  dynamic parentId;
  String name;
  bool isActive;
  int position;
  int level;
  int productCount;
  List<Product> products;
  List<HomeResponse> childrenData;

  factory HomeResponse.fromRawJson(String str) =>
      HomeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        isActive: json["is_active"],
        position: json["position"],
        level: json["level"],
        productCount: json["product_count"],
        childrenData: List<HomeResponse>.from(
            json["children_data"].map((x) => HomeResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "is_active": isActive,
        "position": position,
        "level": level,
        "product_count": productCount,
        "children_data":
            List<dynamic>.from(childrenData.map((x) => x.toJson())),
      };
}
