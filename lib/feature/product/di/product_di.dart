import '../../../global_imports.dart';
import '../data/datasource/product_data_source.dart';
import '../data/repository/product_repo_impl.dart';
import '../domain/repository/product_repo.dart';
import '../domain/usecases/get_product_usecase.dart';
import '../presentation/cubit/product_cubit.dart';

void initProductDI() {
  // Data Source
  getIt.registerLazySingleton<ProductDataSource>(
    () => ProductDataSource(apiServices: getIt<ApiServices>()),
  );

  // Repository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepoImpl(productDataSource: getIt<ProductDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetProduct>(
    () => GetProduct(repository: getIt<ProductRepository>()),
  );

  // Cubit
  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(getProduct: getIt<GetProduct>()),
  );
}
