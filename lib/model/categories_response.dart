import 'dart:convert';

class CategoriesResponse {
  CategoriesResponse({
    this.data,
  });

  Data data;

  factory CategoriesResponse.fromRawJson(String str) =>
      CategoriesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.categoryList,
  });

  List<CategoryList> categoryList;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryList: List<CategoryList>.from(
            json["categoryList"].map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
      };
}

class CategoryList {
  CategoryList({
    this.childrenCount,
    this.children,
  });

  String childrenCount;
  List<CategoryChild> children;

  factory CategoryList.fromRawJson(String str) =>
      CategoryList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        childrenCount: json["children_count"],
        children: List<CategoryChild>.from(
            json["children"].map((x) => CategoryChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "children_count": childrenCount,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class CategoryChild {
  CategoryChild({
    this.id,
    this.level,
    this.name,
    this.path,
    this.urlPath,
    this.urlKey,
    this.image,
    this.description,
    this.children,
  });

  int id;
  int level;
  String name;
  String path;
  String urlPath;
  String urlKey;
  String image;
  dynamic description;
  List<CategoryChild> children;

  factory CategoryChild.fromRawJson(String str) =>
      CategoryChild.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryChild.fromJson(Map<String, dynamic> json) => CategoryChild(
        id: json["id"],
        level: json["level"],
        name: json["name"],
        path: json["path"],
        urlPath: json["url_path"],
        urlKey: json["url_key"],
        image: json["image"] == null ? null : json["image"],
        description: json["description"],
        children: json["children"] == null
            ? null
            : List<CategoryChild>.from(
                json["children"].map((x) => CategoryChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "name": name,
        "path": path,
        "url_path": urlPath,
        "url_key": urlKey,
        "image": image == null ? null : image,
        "description": description,
        "children": children == null
            ? null
            : List<dynamic>.from(children.map((x) => x.toJson())),
      };
}
