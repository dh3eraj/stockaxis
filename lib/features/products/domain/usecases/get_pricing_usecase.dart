import 'package:dartz/dartz.dart';
import 'package:stockaxis/core/status/failure.dart';
import 'package:stockaxis/features/products/data/models/pricing_model.dart';
import 'package:stockaxis/features/products/domain/repository/product_repository.dart';

class GetPricingUsecase {
  final ProductRepository _repository;
  const GetPricingUsecase(this._repository);
  Future<Either<Failure, List<PricingModel>>> call() async {
    return await _repository.getPricing();
  }
}
