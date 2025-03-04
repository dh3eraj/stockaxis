import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stockaxis/features/products/data/models/pricing_model.dart';
import 'package:stockaxis/features/products/data/models/products_response_model.dart.dart';
import 'package:stockaxis/features/products/domain/usecases/get_pricing_usecase.dart';
import 'package:stockaxis/features/products/domain/usecases/get_product_usecase.dart';

part 'products_cubit.freezed.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductUsecase _getProductUsecase;
  final GetPricingUsecase _getPricingUsecase;
  ProductsCubit(this._getProductUsecase, this._getPricingUsecase)
    : super(ProductsState.initial());

  Future<void> getProduct(
    String pkgName, {
    String action = 'search',
    String activity = 'PricingV2',
    String cid = '984493',
  }) async {
    emit(ProductsState.loadingProducts());
    final response = await _getProductUsecase(pkgName, action, activity, cid);
    response.fold(
      (failure) {
        emit(ProductsState.loadProductsError(failure.message));
      },
      (products) {
        emit(ProductsState.loadedProducts(products));
      },
    );
  }

  Future<void> getPricing() async {
    emit(ProductsState.loadingPricing());
    final response = await _getPricingUsecase();
    response.fold(
      (failure) {
        emit(ProductsState.loadPricingError(failure.message));
      },
      (pricing) {
        emit(ProductsState.loadedPricing(pricing));
      },
    );
  }
  Future<void> calculateTotalPayment() async {
    emit(ProductsState.calculatingTotalPayment());
    emit(ProductsState.calculatedTotalPayment());
  }

}
