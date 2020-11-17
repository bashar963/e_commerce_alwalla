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
}
