part of 'products_cubit.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;

  const factory ProductsState.loadingProducts() = _LoadingProducts;
  const factory ProductsState.loadedProducts(List<Product> products) =
      _LoadedProducts;
  const factory ProductsState.loadProductsError(String error) =
      _LoadProductsError;

  const factory ProductsState.loadingPricing() = _LoadingPricing;
  const factory ProductsState.loadedPricing(List<PricingModel> products) =
      _LoadedPricing;
  const factory ProductsState.loadPricingError(String error) =
      _LoadPricingError;

  const factory ProductsState.calculatingTotalPayment() = _CalculatingTotalPayment;
  const factory ProductsState.calculatedTotalPayment() = _CalculatedTotalPayment;
}
