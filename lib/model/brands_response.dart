import 'dart:convert';

class BrandsResponse {
  BrandsResponse({
    this.label,
    this.value,
  });

  String label;
  String value;

  factory BrandsResponse.fromRawJson(String str) =>
      BrandsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandsResponse.fromJson(Map<String, dynamic> json) => BrandsResponse(
        label: json["label"] == null ? null : json["label"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label == null ? null : label,
        "value": value == null ? null : value,
      };
}
