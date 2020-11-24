// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MainApi extends MainApi {
  _$MainApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MainApi;

  @override
  Future<Response<dynamic>> login(String username, String password) {
    final $url =
        'http://mymalleg.com/index.php/rest/V1/integration/customer/token';
    final $body = <String, dynamic>{'username': username, 'password': password};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> signUp(Map<String, dynamic> data) {
    final $url = 'http://mymalleg.com/index.php/rest/V1/customers';
    final $body = data;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserData(String token) {
    final $url = 'http://mymalleg.com/index.php/rest/V1/customers/me';
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getShippingMethods(
      String token, Map<String, dynamic> body) {
    final $url =
        'http://mymalleg.com/index.php/rest/V1/carts/mine/estimate-shipping-methods';
    final $headers = {'Authorization': token};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> placeOrder(
      String token, Map<String, dynamic> body) {
    final $url = 'http://mymalleg.com/index.php/rest/V1/carts/mine/order';
    final $headers = {'Authorization': token};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPaymentMethods(
      String token, Map<String, dynamic> body) {
    final $url =
        'http://mymalleg.com/index.php/rest/V1/carts/mine/shipping-information';
    final $headers = {'Authorization': token};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteItemInCart(String token, String itemId) {
    final $url =
        'http://mymalleg.com/index.php/rest/V1/carts/mine/items/$itemId';
    final $headers = {'Authorization': token};
    final $request = Request('DELETE', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> editItemInCart(
      String token, String itemId, Map<String, dynamic> body) {
    final $url =
        'http://mymalleg.com/index.php/rest/V1/carts/mine/items/$itemId';
    final $headers = {'Authorization': token};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCart(String token) {
    final $url = 'http://mymalleg.com/index.php/rest/V1/carts/mine';
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getProducts() {
    final $url =
        'http://mymalleg.com/index.php/rest/V1/products?searchCriteria';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> updateUserProfile(
      String token, Map<String, dynamic> body) {
    final $url = 'http://mymalleg.com/index.php/rest/V1/customers/me';
    final $headers = {'Authorization': token};
    final $body = body;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> isEmailAvailable(String email) {
    final $url =
        'http://mymalleg.com/index.php/rest/V1/customers/isEmailAvailable';
    final $body = <String, dynamic>{'customerEmail': email};
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> sendPasswordRestore(Map<String, dynamic> body) {
    final $url = 'http://mymalleg.com/index.php/rest/V1/customers/password';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
