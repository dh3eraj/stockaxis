import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:stockaxis/core/constants/api_strings.dart';
import 'package:stockaxis/features/products/data/datasources/remote/product_remote_client.dart';
import 'package:stockaxis/features/products/data/repository/product_repository_impl.dart';
import 'package:stockaxis/features/products/domain/repository/product_repository.dart';
import 'package:stockaxis/features/products/domain/usecases/get_pricing_usecase.dart';
import 'package:stockaxis/features/products/domain/usecases/get_product_usecase.dart';
import 'package:stockaxis/features/products/presentation/bloc/products_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<Dio>(() {
    final BaseOptions options = BaseOptions(
      baseUrl: ApiStrings.baseUrl,
      contentType: Headers.jsonContentType,
    );
    final Dio dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          responseHeader: false,
          responseBody: false,
          error: true,
        ),
      );
    }
    return dio;
  });

  sl.registerFactory(() => ProductsCubit(sl(),sl()));
  sl.registerSingleton(ProductRemoteClient(sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(sl()));
  sl.registerSingleton(GetProductUsecase(sl()));
    sl.registerSingleton(GetPricingUsecase(sl()));

}
