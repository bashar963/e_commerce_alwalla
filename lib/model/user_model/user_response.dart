// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

class UserResponse {
  UserResponse({
    this.id,
    this.groupId,
    this.createdAt,
    this.updatedAt,
    this.createdIn,
    this.email,
    this.firstname,
    this.lastname,
    this.dob,
    this.gender,
    this.storeId,
    this.websiteId,
    this.addresses,
    this.disableAutoGroupChange,
    this.extensionAttributes,
  });

  int id;
  int groupId;
  DateTime createdAt;
  DateTime updatedAt;
  String createdIn;
  String email;
  String firstname;
  String lastname;
  String dob;
  String gender;
  int storeId;
  int websiteId;
  List<dynamic> addresses;
  int disableAutoGroupChange;
  ExtensionAttributes extensionAttributes;

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        groupId: json["group_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdIn: json["created_in"],
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        dob: json["dob"],
        gender: json["gender"],
        storeId: json["store_id"],
        websiteId: json["website_id"],
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
        disableAutoGroupChange: json["disable_auto_group_change"],
        extensionAttributes:
            ExtensionAttributes.fromJson(json["extension_attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_in": createdIn,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "dob": dob,
        "gender": gender,
        "store_id": storeId,
        "website_id": websiteId,
        "addresses": List<dynamic>.from(addresses.map((x) => x)),
        "disable_auto_group_change": disableAutoGroupChange,
        "extension_attributes": extensionAttributes.toJson(),
      };
}

class ExtensionAttributes {
  ExtensionAttributes({
    this.isSubscribed,
  });

  bool isSubscribed;

  factory ExtensionAttributes.fromRawJson(String str) =>
      ExtensionAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      ExtensionAttributes(
        isSubscribed: json["is_subscribed"],
      );

  Map<String, dynamic> toJson() => {
        "is_subscribed": isSubscribed,
      };
}
