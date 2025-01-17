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

  @Post(path: '/carts/mine/estimate-shipping-methods')
  Future<Response> getShippingMethods(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @Put(path: '/carts/mine/order')
  Future<Response> placeOrder(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @Post(path: '/carts/mine/shipping-information')
  Future<Response> getPaymentMethods(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @Delete(path: '/carts/mine/items/{item_id}')
  Future<Response> deleteItemInCart(
      @Header('Authorization') String token, @Path('item_id') String itemId);

  @Put(path: '/carts/mine/items/{item_id}')
  Future<Response> editItemInCart(@Header('Authorization') String token,
      @Path('item_id') String itemId, @Body() Map<String, dynamic> body);

  @Post(path: '/carts/mine/items')
  Future<Response> addItemToCart(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @Get(path: '/carts/mine')
  Future<Response> getCart(@Header('Authorization') String token);

  @Post(path: '/carts/mine')
  Future<Response> getQuoteId(@Header('Authorization') String token);

  @Get(path: '/guest-carts/{cartId}')
  Future<Response> getCartGuest(@Path('cartId') String cartMask);

  @Post(path: '/guest-carts')
  Future<Response> getQuoteIdGuest();

  @Delete(path: '/guest-carts/{cartId}/items/{item_id}')
  Future<Response> deleteItemInCartGuest(
      @Path('cartId') String cartId, @Path('item_id') String itemId);

  @Put(path: '/guest-carts/{cartId}/items/{item_id}')
  Future<Response> editItemInCartGuest(@Path('cartId') String cartId,
      @Path('item_id') String itemId, @Body() Map<String, dynamic> body);

  @Post(path: '/guest-carts/{cartId}/items')
  Future<Response> addItemToCartGuest(
      @Path('cartId') String cartId, @Body() Map<String, dynamic> body);

  @Get(path: '/products?searchCriteria')
  Future<Response> getProducts();

  @Put(path: '/customers/me')
  Future<Response> updateUserProfile(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @Get(path: '/customers/isEmailAvailable')
  Future<Response> isEmailAvailable(@Field('customerEmail') String email);

  @Put(path: '/customers/password')
  Future<Response> sendPasswordRestore(@Body() Map<String, dynamic> body);
}
