class SignUpRequest {
  Customer customer;
  String password;

  SignUpRequest({this.customer, this.password});

  SignUpRequest.fromJson(dynamic json) {
    customer =
        json["customer"] != null ? Customer.fromJson(json["customer"]) : null;
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (customer != null) {
      map["customer"] = customer.toJson();
    }
    map["password"] = password;
    return map;
  }
}

class Customer {
  String lastname;
  String firstname;
  String email;

  Customer({this.lastname, this.firstname, this.email});

  Customer.fromJson(dynamic json) {
    lastname = json["lastname"];
    firstname = json["firstname"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lastname"] = lastname;
    map["firstname"] = firstname;
    map["email"] = email;
    return map;
  }
}
