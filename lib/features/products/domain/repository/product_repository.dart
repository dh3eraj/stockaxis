import 'package:dartz/dartz.dart';
import 'package:stockaxis/core/status/failure.dart';
import 'package:stockaxis/features/products/data/models/pricing_model.dart';
import 'package:stockaxis/features/products/data/models/products_response_model.dart.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts(
    String pkgName,
    String action,
    String activity,
    String cid,
  );
  Future<Either<Failure, List<PricingModel>>> getPricing();
}
