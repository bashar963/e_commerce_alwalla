import 'dart:convert';

class CustomerRequest {
  CustomerRequest({
    this.customer,
  });

  CustomerClass customer;

  factory CustomerRequest.fromRawJson(String str) =>
      CustomerRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerRequest.fromJson(Map<String, dynamic> json) =>
      CustomerRequest(
        customer: CustomerClass.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
      };
}

class CustomerClass {
  CustomerClass({
    this.id,
    this.groupId,
    this.defaultBilling,
    this.defaultShipping,
    this.confirmation,
    this.createdAt,
    this.updatedAt,
    this.createdIn,
    this.dob,
    this.email,
    this.firstname,
    this.lastname,
    this.middlename,
    this.prefix,
    this.suffix,
    this.gender,
    this.storeId,
    this.taxvat,
    this.websiteId,
    this.addresses,
    this.disableAutoGroupChange,
    this.extensionAttributes,
    this.customAttributes,
  });

  int id;
  int groupId;
  String defaultBilling;
  String defaultShipping;
  String confirmation;
  String createdAt;
  String updatedAt;
  String createdIn;
  String dob;
  String email;
  String firstname;
  String lastname;
  String middlename;
  String prefix;
  String suffix;
  int gender;
  int storeId;
  String taxvat;
  int websiteId;
  List<Address> addresses;
  int disableAutoGroupChange;
  CustomerExtensionAttributes extensionAttributes;
  List<CustomAttribute> customAttributes;

  factory CustomerClass.fromRawJson(String str) =>
      CustomerClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerClass.fromJson(Map<String, dynamic> json) => CustomerClass(
        id: json["id"],
        groupId: json["group_id"],
        defaultBilling: json["default_billing"],
        defaultShipping: json["default_shipping"],
        confirmation: json["confirmation"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        createdIn: json["created_in"],
        dob: json["dob"],
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        middlename: json["middlename"],
        prefix: json["prefix"],
        suffix: json["suffix"],
        gender: json["gender"],
        storeId: json["store_id"],
        taxvat: json["taxvat"],
        websiteId: json["website_id"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        disableAutoGroupChange: json["disable_auto_group_change"],
        extensionAttributes:
            CustomerExtensionAttributes.fromJson(json["extension_attributes"]),
        customAttributes: List<CustomAttribute>.from(
            json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "default_billing": defaultBilling,
        "default_shipping": defaultShipping,
        "confirmation": confirmation,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "created_in": createdIn,
        "dob": dob,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "middlename": middlename,
        "prefix": prefix,
        "suffix": suffix,
        "gender": gender,
        "store_id": storeId,
        "taxvat": taxvat,
        "website_id": websiteId,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "disable_auto_group_change": disableAutoGroupChange,
        "extension_attributes": extensionAttributes.toJson(),
        "custom_attributes":
            List<dynamic>.from(customAttributes.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.customerId,
    this.region,
    this.regionId,
    this.countryId,
    this.street,
    this.company,
    this.telephone,
    this.fax,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.middlename,
    this.prefix,
    this.suffix,
    this.vatId,
    this.defaultShipping,
    this.defaultBilling,
    this.extensionAttributes,
    this.customAttributes,
  });

  int id;
  int customerId;
  Region region;
  int regionId;
  String countryId;
  List<String> street;
  String company;
  String telephone;
  String fax;
  String postcode;
  String city;
  String firstname;
  String lastname;
  String middlename;
  String prefix;
  String suffix;
  String vatId;
  bool defaultShipping;
  bool defaultBilling;
  AddressExtensionAttributes extensionAttributes;
  List<CustomAttribute> customAttributes;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        customerId: json["customer_id"],
        region: Region.fromJson(json["region"]),
        regionId: json["region_id"],
        countryId: json["country_id"],
        street: List<String>.from(json["street"].map((x) => x)),
        company: json["company"],
        telephone: json["telephone"],
        fax: json["fax"],
        postcode: json["postcode"],
        city: json["city"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        middlename: json["middlename"],
        prefix: json["prefix"],
        suffix: json["suffix"],
        vatId: json["vat_id"],
        defaultShipping: json["default_shipping"],
        defaultBilling: json["default_billing"],
        extensionAttributes:
            AddressExtensionAttributes.fromJson(json["extension_attributes"]),
        customAttributes: List<CustomAttribute>.from(
            json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "region": region.toJson(),
        "region_id": regionId,
        "country_id": countryId,
        "street": List<dynamic>.from(street.map((x) => x)),
        "company": company,
        "telephone": telephone,
        "fax": fax,
        "postcode": postcode,
        "city": city,
        "firstname": firstname,
        "lastname": lastname,
        "middlename": middlename,
        "prefix": prefix,
        "suffix": suffix,
        "vat_id": vatId,
        "default_shipping": defaultShipping,
        "default_billing": defaultBilling,
        "extension_attributes": extensionAttributes.toJson(),
        "custom_attributes":
            List<dynamic>.from(customAttributes.map((x) => x.toJson())),
      };
}

class CustomAttribute {
  CustomAttribute({
    this.attributeCode,
    this.value,
  });

  String attributeCode;
  String value;

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

class AddressExtensionAttributes {
  AddressExtensionAttributes();

  factory AddressExtensionAttributes.fromRawJson(String str) =>
      AddressExtensionAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      AddressExtensionAttributes();

  Map<String, dynamic> toJson() => {};
}

class Region {
  Region({
    this.regionCode,
    this.region,
    this.regionId,
    this.extensionAttributes,
  });

  String regionCode;
  String region;
  int regionId;
  AddressExtensionAttributes extensionAttributes;

  factory Region.fromRawJson(String str) => Region.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        regionCode: json["region_code"],
        region: json["region"],
        regionId: json["region_id"],
        extensionAttributes:
            AddressExtensionAttributes.fromJson(json["extension_attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "region_code": regionCode,
        "region": region,
        "region_id": regionId,
        "extension_attributes": extensionAttributes.toJson(),
      };
}

class CustomerExtensionAttributes {
  CustomerExtensionAttributes({
    this.companyAttributes,
    this.isSubscribed,
    this.amazonId,
    this.vertexCustomerCode,
  });

  CompanyAttributes companyAttributes;
  bool isSubscribed;
  String amazonId;
  String vertexCustomerCode;

  factory CustomerExtensionAttributes.fromRawJson(String str) =>
      CustomerExtensionAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerExtensionAttributes.fromJson(Map<String, dynamic> json) =>
      CustomerExtensionAttributes(
        companyAttributes:
            CompanyAttributes.fromJson(json["company_attributes"]),
        isSubscribed: json["is_subscribed"],
        amazonId: json["amazon_id"],
        vertexCustomerCode: json["vertex_customer_code"],
      );

  Map<String, dynamic> toJson() => {
        "company_attributes": companyAttributes.toJson(),
        "is_subscribed": isSubscribed,
        "amazon_id": amazonId,
        "vertex_customer_code": vertexCustomerCode,
      };
}

class CompanyAttributes {
  CompanyAttributes({
    this.customerId,
    this.companyId,
    this.jobTitle,
    this.status,
    this.telephone,
    this.extensionAttributes,
  });

  int customerId;
  int companyId;
  String jobTitle;
  int status;
  String telephone;
  AddressExtensionAttributes extensionAttributes;

  factory CompanyAttributes.fromRawJson(String str) =>
      CompanyAttributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAttributes.fromJson(Map<String, dynamic> json) =>
      CompanyAttributes(
        customerId: json["customer_id"],
        companyId: json["company_id"],
        jobTitle: json["job_title"],
        status: json["status"],
        telephone: json["telephone"],
        extensionAttributes:
            AddressExtensionAttributes.fromJson(json["extension_attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "company_id": companyId,
        "job_title": jobTitle,
        "status": status,
        "telephone": telephone,
        "extension_attributes": extensionAttributes.toJson(),
      };
}
