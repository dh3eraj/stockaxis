import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stockaxis/config/di/dependency_injection.dart';
import 'package:stockaxis/features/products/presentation/bloc/products_cubit.dart';
import 'package:stockaxis/features/products/presentation/pages/pricing_screen.dart';

class AppRoutes {
 static GoRouter routerConfig = GoRouter(
    initialLocation: '/pricing',
    routes: [
      GoRoute(
        path: '/pricing',
        builder: (context, state) {
          return BlocProvider(create: (context) {
            return sl<ProductsCubit>();
          },
            child: PricingScreen());
        },
      ),
    ],
  );
}
