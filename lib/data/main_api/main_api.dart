import "dart:async";
import 'package:chopper/chopper.dart';

part "main_api.chopper.dart";

@ChopperApi(baseUrl: 'http://mymalleg.com/rest/V1')
abstract class MainApi extends ChopperService {
  static MainApi create() {
    var client = ChopperClient(
        baseUrl: 'http://mymalleg.com/rest/V1',
        services: [_$MainApi()],
        converter: JsonConverter());
    return _$MainApi(client);
  }

  @Post(path: '/integration/customer/token', headers: {
    'Authorization': 'Basic YWRtaW46QWRtaW4xMjM=',
    'Accept': 'application/json'
  })
  Future<Response> login(
      @Field('username') String username, @Field('password') String password);

  @Post(path: '/customers', headers: {
    'Authorization': 'Basic YWRtaW46QWRtaW4xMjM=',
    'Accept': 'application/json'
  })
  Future<Response> signUp(@Body() Map<String, dynamic> data);

  @Get(path: 'customers/{customerId}', headers: {
    'Accept': 'application/json',
    'Authorization': 'Basic YWRtaW46QWRtaW4xMjM=',
  })
  Future<Response> getUserData(@Path('customerId') String customerId);
}
