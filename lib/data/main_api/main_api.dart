import "dart:async";
import 'package:chopper/chopper.dart';

part "main_api.chopper.dart";

@ChopperApi(baseUrl: 'http://mymalleg.com/index.php/rest/V1')
abstract class MainApi extends ChopperService {
  static MainApi create() {
    var client = ChopperClient(
        baseUrl: 'http://mymalleg.com/index.php/rest/V1',
        services: [_$MainApi()],
        converter: JsonConverter());
    return _$MainApi(client);
  }

  @Post(path: '/integration/customer/token')
  Future<Response> login(
      @Field('username') String username, @Field('password') String password);

  @Post(path: '/customers')
  Future<Response> signUp(@Body() Map<String, dynamic> data);

  @Get(path: '/customers/me')
  Future<Response> getUserData(@Header('Authorization') String token);
}
