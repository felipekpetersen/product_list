import 'package:get_it/get_it.dart';
import 'package:product_list/Cubit/Product/cubit/product_cubit.dart';
import 'package:product_list/Domain/Product/ProductController.dart';

import 'Cubit/Product/cubit/edit_product_cubit.dart';
import 'Repository/Product/product_repo.dart';

final locator = GetIt.instance;

void setupGetIt() {
  locator.registerLazySingleton(() => ProductRepo());
  locator.registerLazySingleton(() => ProductController(locator<ProductRepo>()));
  locator.registerLazySingleton(() => ProductCubit(locator<ProductController>()));

  locator.registerLazySingleton(() => DetailProductCubit(locator<ProductController>()));

}
