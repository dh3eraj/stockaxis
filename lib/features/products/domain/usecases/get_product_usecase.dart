import 'package:dartz/dartz.dart';
import 'package:stockaxis/core/status/failure.dart';
import 'package:stockaxis/features/products/data/models/products_response_model.dart.dart';
import 'package:stockaxis/features/products/domain/repository/product_repository.dart';

class GetProductUsecase {
  final ProductRepository _repository;
  const GetProductUsecase(this._repository);
  Future<Either<Failure, List<Product>>> call(String pkgName, 
  String action,
  String activity,
  String cid,
) async {
    return await _repository.getProducts(pkgName,action,action,cid);
  }
}
