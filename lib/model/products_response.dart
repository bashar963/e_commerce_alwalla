import 'dart:convert';

class ProductsResponse {
  ProductsResponse({
    this.items,
    this.totalCount,
  });

  List<Product> items;
  int totalCount;

  factory ProductsResponse.fromRawJson(String str) =>
      ProductsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      ProductsResponse(
        items:
            List<Product>.from(json["items"].map((x) => Product.fromJson(x))),
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total_count": totalCount,
      };
}

class Product {
  Product({
    this.id,
    this.sku,
    this.name,
    this.attributeSetId,
    this.price,
    this.status,
    this.visibility,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.extensionAttributes,
    this.productLinks,
    this.options,
    this.mediaGalleryEntries,
    this.tierPrices,
    this.customAttributes,
    this.weight,
  });

  int id;
  String sku;
  String name;
  int attributeSetId;
  dynamic price;
  int status;
  int visibility;
  String typeId;
  DateTime createdAt;
  DateTime updatedAt;
  ItemExtensionAttributes extensionAttributes;
  List<ItemProductLink> productLinks;
  List<Option> options;
  List<MediaGalleryEntry> mediaGalleryEntries;
  List<dynamic> tierPrices;
  List<CustomAttribute> customAttributes;
  dynamic weight;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        sku: json["sku"],
        name: json["name"],
        attributeSetId: json["attribute_set_id"],
        price: json["price"] == null ? null : json["price"],
        status: json["status"],
        visibility: json["visibility"],
        typeId: json["type_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        extensionAttributes:
            ItemExtensionAttributes.fromJson(json["extension_attributes"]),
        productLinks: List<ItemProductLink>.from(
            json["product_links"].map((x) => ItemProductLink.fromJson(x))),
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        mediaGalleryEntries: List<MediaGalleryEntry>.from(
            json["media_gallery_entries"]
                .map((x) => MediaGalleryEntry.fromJson(x))),
        tierPrices: List<dynamic>.from(json["tier_prices"].map((x) => x)),
        customAttributes: List<CustomAttribute>.from(
            json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
        weight: json["weight"] == null ? null : json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "attribute_set_id": attributeSetId,
        "price": price == null ? null : price,
        "status": status,
        "visibility": visibility,
        "type_id": typeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "extension_attributes": extensionAttributes.toJson(),
        "product_links":
            List<dynamic>.from(productLinks.map((x) => x.toJson())),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "media_gallery_entries":
            List<dynamic>.from(mediaGalleryEntries.map((x) => x.toJson())),
        "tier_prices": List<dynamic>.from(tierPrices.map((x) => x)),
        "custom_attributes":
            List<dynamic>.from(customAttributes.map((x) => x.toJson())),
        "weight": weight == null ? null : weight,
      };
}

class CustomAttribute {
  CustomAttribute({
    this.attributeCode,
    this.value,
  });

  String attributeCode;
  dynamic value;

  factory CustomAttribute.fromRawJson(String str) =>
      CustomAttribute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomAttribute.fromJson(Map<String, dynamic> json) =>
      CustomAttribute(
        attributeCode: json["attribute_code"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "attribute_code": attributeCode,
        "value": value,
      };
}

class ItemExtensionAttributes {
  ItemExtensionAttributes({
    this.websiteIds,
    this.categoryLinks,
    this.bundleProductOptions,
    this.downloadableProductLinks,
    this.downloadableProductSamples,
    this.configurableProductOptions,
    this.configurableProductLinks,
  });

  List<int> websiteIds;
  List<CategoryLink> categoryLinks;
  List<BundleProductOption> bundleProductOptions;
  List<DownloadableProductLink> downloadableProductLinks;
  List<DownloadableProductSample> downloadableProductSamples;
  List<ConfigurableProductOption> configurableProductOptions;
  List<int> configurableProductLinks;

  factory ItemExtensionAttributes.fromRawJson(String str) =>
      ItemExtensionAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      ItemExtensionAttributes(
        websiteIds: List<int>.from(json["website_ids"].map((x) => x)),
        categoryLinks: List<CategoryLink>.from(
            json["category_links"].map((x) => CategoryLink.fromJson(x))),
        bundleProductOptions: json["bundle_product_options"] == null
            ? null
            : List<BundleProductOption>.from(json["bundle_product_options"]
                .map((x) => BundleProductOption.fromJson(x))),
        downloadableProductLinks: json["downloadable_product_links"] == null
            ? null
            : List<DownloadableProductLink>.from(
                json["downloadable_product_links"]
                    .map((x) => DownloadableProductLink.fromJson(x))),
        downloadableProductSamples: json["downloadable_product_samples"] == null
            ? null
            : List<DownloadableProductSample>.from(
                json["downloadable_product_samples"]
                    .map((x) => DownloadableProductSample.fromJson(x))),
        configurableProductOptions: json["configurable_product_options"] == null
            ? null
            : List<ConfigurableProductOption>.from(
                json["configurable_product_options"]
                    .map((x) => ConfigurableProductOption.fromJson(x))),
        configurableProductLinks: json["configurable_product_links"] == null
            ? null
            : List<int>.from(json["configurable_product_links"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "website_ids": List<dynamic>.from(websiteIds.map((x) => x)),
        "category_links":
            List<dynamic>.from(categoryLinks.map((x) => x.toJson())),
        "bundle_product_options": bundleProductOptions == null
            ? null
            : List<dynamic>.from(bundleProductOptions.map((x) => x.toJson())),
        "downloadable_product_links": downloadableProductLinks == null
            ? null
            : List<dynamic>.from(
                downloadableProductLinks.map((x) => x.toJson())),
        "downloadable_product_samples": downloadableProductSamples == null
            ? null
            : List<dynamic>.from(
                downloadableProductSamples.map((x) => x.toJson())),
        "configurable_product_options": configurableProductOptions == null
            ? null
            : List<dynamic>.from(
                configurableProductOptions.map((x) => x.toJson())),
        "configurable_product_links": configurableProductLinks == null
            ? null
            : List<dynamic>.from(configurableProductLinks.map((x) => x)),
      };
}

class BundleProductOption {
  BundleProductOption({
    this.optionId,
    this.title,
    this.required,
    this.type,
    this.position,
    this.sku,
    this.productLinks,
  });

  int optionId;
  String title;
  bool required;
  String type;
  int position;
  String sku;
  List<BundleProductOptionProductLink> productLinks;

  factory BundleProductOption.fromRawJson(String str) =>
      BundleProductOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BundleProductOption.fromJson(Map<String, dynamic> json) =>
      BundleProductOption(
        optionId: json["option_id"],
        title: json["title"],
        required: json["required"],
        type: json["type"],
        position: json["position"],
        sku: json["sku"],
        productLinks: List<BundleProductOptionProductLink>.from(
            json["product_links"]
                .map((x) => BundleProductOptionProductLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "option_id": optionId,
        "title": title,
        "required": required,
        "type": type,
        "position": position,
        "sku": sku,
        "product_links":
            List<dynamic>.from(productLinks.map((x) => x.toJson())),
      };
}

class BundleProductOptionProductLink {
  BundleProductOptionProductLink({
    this.id,
    this.sku,
    this.optionId,
    this.qty,
    this.position,
    this.isDefault,
    this.price,
    this.priceType,
    this.canChangeQuantity,
  });

  String id;
  String sku;
  int optionId;
  int qty;
  int position;
  bool isDefault;
  dynamic price;
  dynamic priceType;
  int canChangeQuantity;

  factory BundleProductOptionProductLink.fromRawJson(String str) =>
      BundleProductOptionProductLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BundleProductOptionProductLink.fromJson(Map<String, dynamic> json) =>
      BundleProductOptionProductLink(
        id: json["id"],
        sku: json["sku"],
        optionId: json["option_id"],
        qty: json["qty"],
        position: json["position"],
        isDefault: json["is_default"],
        price: json["price"],
        priceType: json["price_type"],
        canChangeQuantity: json["can_change_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "option_id": optionId,
        "qty": qty,
        "position": position,
        "is_default": isDefault,
        "price": price,
        "price_type": priceType,
        "can_change_quantity": canChangeQuantity,
      };
}

class CategoryLink {
  CategoryLink({
    this.position,
    this.categoryId,
  });

  int position;
  String categoryId;

  factory CategoryLink.fromRawJson(String str) =>
      CategoryLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryLink.fromJson(Map<String, dynamic> json) => CategoryLink(
        position: json["position"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "category_id": categoryId,
      };
}

class ConfigurableProductOption {
  ConfigurableProductOption({
    this.id,
    this.attributeId,
    this.label,
    this.position,
    this.values,
    this.productId,
  });

  int id;
  String attributeId;
  String label;
  int position;
  List<ConfigurableProductOptionValue> values;
  int productId;

  factory ConfigurableProductOption.fromRawJson(String str) =>
      ConfigurableProductOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfigurableProductOption.fromJson(Map<String, dynamic> json) =>
      ConfigurableProductOption(
        id: json["id"],
        attributeId: json["attribute_id"],
        label: json["label"],
        position: json["position"],
        values: List<ConfigurableProductOptionValue>.from(json["values"]
            .map((x) => ConfigurableProductOptionValue.fromJson(x))),
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attribute_id": attributeId,
        "label": label,
        "position": position,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
        "product_id": productId,
      };
}

class ConfigurableProductOptionValue {
  ConfigurableProductOptionValue({
    this.valueIndex,
  });

  int valueIndex;

  factory ConfigurableProductOptionValue.fromRawJson(String str) =>
      ConfigurableProductOptionValue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConfigurableProductOptionValue.fromJson(Map<String, dynamic> json) =>
      ConfigurableProductOptionValue(
        valueIndex: json["value_index"],
      );

  Map<String, dynamic> toJson() => {
        "value_index": valueIndex,
      };
}

class DownloadableProductLink {
  DownloadableProductLink({
    this.id,
    this.title,
    this.sortOrder,
    this.isShareable,
    this.price,
    this.numberOfDownloads,
    this.linkType,
    this.linkFile,
    this.sampleType,
    this.sampleFile,
  });

  int id;
  String title;
  int sortOrder;
  int isShareable;
  int price;
  int numberOfDownloads;
  String linkType;
  String linkFile;
  String sampleType;
  String sampleFile;

  factory DownloadableProductLink.fromRawJson(String str) =>
      DownloadableProductLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DownloadableProductLink.fromJson(Map<String, dynamic> json) =>
      DownloadableProductLink(
        id: json["id"],
        title: json["title"],
        sortOrder: json["sort_order"],
        isShareable: json["is_shareable"],
        price: json["price"],
        numberOfDownloads: json["number_of_downloads"],
        linkType: json["link_type"],
        linkFile: json["link_file"],
        sampleType: json["sample_type"],
        sampleFile: json["sample_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sort_order": sortOrder,
        "is_shareable": isShareable,
        "price": price,
        "number_of_downloads": numberOfDownloads,
        "link_type": linkType,
        "link_file": linkFile,
        "sample_type": sampleType,
        "sample_file": sampleFile,
      };
}

class DownloadableProductSample {
  DownloadableProductSample({
    this.id,
    this.title,
    this.sortOrder,
    this.sampleType,
    this.sampleFile,
  });

  int id;
  String title;
  int sortOrder;
  String sampleType;
  String sampleFile;

  factory DownloadableProductSample.fromRawJson(String str) =>
      DownloadableProductSample.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DownloadableProductSample.fromJson(Map<String, dynamic> json) =>
      DownloadableProductSample(
        id: json["id"],
        title: json["title"],
        sortOrder: json["sort_order"],
        sampleType: json["sample_type"],
        sampleFile: json["sample_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sort_order": sortOrder,
        "sample_type": sampleType,
        "sample_file": sampleFile,
      };
}

class MediaGalleryEntry {
  MediaGalleryEntry({
    this.id,
    this.mediaType,
    this.label,
    this.position,
    this.disabled,
    this.types,
    this.file,
  });

  int id;
  Type mediaType;
  dynamic label;
  int position;
  bool disabled;
  List<Type> types;
  String file;

  factory MediaGalleryEntry.fromRawJson(String str) =>
      MediaGalleryEntry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaGalleryEntry.fromJson(Map<String, dynamic> json) =>
      MediaGalleryEntry(
        id: json["id"],
        mediaType: typeValues.map[json["media_type"]],
        label: json["label"],
        position: json["position"],
        disabled: json["disabled"],
        types: List<Type>.from(json["types"].map((x) => typeValues.map[x])),
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "media_type": typeValues.reverse[mediaType],
        "label": label,
        "position": position,
        "disabled": disabled,
        "types": List<dynamic>.from(types.map((x) => typeValues.reverse[x])),
        "file": file,
      };
}

enum Type { IMAGE, SMALL_IMAGE, THUMBNAIL, SWATCH_IMAGE }

final typeValues = EnumValues({
  "image": Type.IMAGE,
  "small_image": Type.SMALL_IMAGE,
  "swatch_image": Type.SWATCH_IMAGE,
  "thumbnail": Type.THUMBNAIL
});

class Option {
  Option({
    this.productSku,
    this.optionId,
    this.title,
    this.type,
    this.sortOrder,
    this.isRequire,
    this.maxCharacters,
    this.imageSizeX,
    this.imageSizeY,
    this.values,
  });

  String productSku;
  dynamic optionId;
  String title;
  String type;
  int sortOrder;
  bool isRequire;
  int maxCharacters;
  int imageSizeX;
  int imageSizeY;
  List<OptionValue> values;

  factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        productSku: json["product_sku"],
        optionId: json["option_id"],
        title: json["title"],
        type: json["type"],
        sortOrder: json["sort_order"],
        isRequire: json["is_require"],
        maxCharacters: json["max_characters"],
        imageSizeX: json["image_size_x"],
        imageSizeY: json["image_size_y"],
        values: List<OptionValue>.from(
            json["values"].map((x) => OptionValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_sku": productSku,
        "option_id": optionId,
        "title": title,
        "type": type,
        "sort_order": sortOrder,
        "is_require": isRequire,
        "max_characters": maxCharacters,
        "image_size_x": imageSizeX,
        "image_size_y": imageSizeY,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class OptionValue {
  OptionValue({
    this.title,
    this.sortOrder,
    this.price,
    this.priceType,
    this.optionTypeId,
  });
  bool isSelected = false;
  String title;
  int sortOrder;
  dynamic price;
  PriceType priceType;
  dynamic optionTypeId;

  factory OptionValue.fromRawJson(String str) =>
      OptionValue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OptionValue.fromJson(Map<String, dynamic> json) => OptionValue(
        title: json["title"],
        sortOrder: json["sort_order"],
        price: json["price"],
        priceType: priceTypeValues.map[json["price_type"]],
        optionTypeId: json["option_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "sort_order": sortOrder,
        "price": price,
        "price_type": priceTypeValues.reverse[priceType],
        "option_type_id": optionTypeId,
      };
}

enum PriceType { FIXED }

final priceTypeValues = EnumValues({"fixed": PriceType.FIXED});

class ItemProductLink {
  ItemProductLink({
    this.sku,
    this.linkType,
    this.linkedProductSku,
    this.linkedProductType,
    this.position,
    this.extensionAttributes,
  });

  String sku;
  LinkType linkType;
  String linkedProductSku;
  LinkedProductType linkedProductType;
  int position;
  ProductLinkExtensionAttributes extensionAttributes;

  factory ItemProductLink.fromRawJson(String str) =>
      ItemProductLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemProductLink.fromJson(Map<String, dynamic> json) =>
      ItemProductLink(
        sku: json["sku"],
        linkType: linkTypeValues.map[json["link_type"]],
        linkedProductSku: json["linked_product_sku"],
        linkedProductType:
            linkedProductTypeValues.map[json["linked_product_type"]],
        position: json["position"],
        extensionAttributes: json["extension_attributes"] == null
            ? null
            : ProductLinkExtensionAttributes.fromJson(
                json["extension_attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "sku": sku,
        "link_type": linkTypeValues.reverse[linkType],
        "linked_product_sku": linkedProductSku,
        "linked_product_type":
            linkedProductTypeValues.reverse[linkedProductType],
        "position": position,
        "extension_attributes":
            extensionAttributes == null ? null : extensionAttributes.toJson(),
      };
}

class ProductLinkExtensionAttributes {
  ProductLinkExtensionAttributes({
    this.qty,
  });

  int qty;

  factory ProductLinkExtensionAttributes.fromRawJson(String str) =>
      ProductLinkExtensionAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductLinkExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      ProductLinkExtensionAttributes(
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "qty": qty,
      };
}

enum LinkType { RELATED, ASSOCIATED }

final linkTypeValues = EnumValues(
    {"associated": LinkType.ASSOCIATED, "related": LinkType.RELATED});

enum LinkedProductType { SIMPLE, VIRTUAL }

final linkedProductTypeValues = EnumValues(
    {"simple": LinkedProductType.SIMPLE, "virtual": LinkedProductType.VIRTUAL});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
