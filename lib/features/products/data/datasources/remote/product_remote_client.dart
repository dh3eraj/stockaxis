import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stockaxis/core/constants/api_strings.dart';
import 'package:stockaxis/features/products/data/models/products_response_model.dart.dart';
part 'product_remote_client.g.dart';

@RestApi()
abstract class ProductRemoteClient {
  factory ProductRemoteClient(Dio dio) = _ProductRemoteClient;
  @GET(ApiStrings.product)
  Future<ProductsResponseModel> getProducts(
    @Query('PKGName') String pkgName,
    @Query('action') String action,
    @Query('activity') String activity,
    @Query('CID') String cid, {
    @Header('Accept') String accept = '"application/json"',
  });
  @GET(ApiStrings.pricing)
  Future<HttpResponse> getPricing();
}
