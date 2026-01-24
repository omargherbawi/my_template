import '../../../../global_imports.dart';
import '../../data/datasource/product_data_source.dart';
import '../../data/repository/product_repo_impl.dart';
import '../../domain/usecases/get_product_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState>  {
  // We'll add the use case here later
  ProductCubit() : super(ProductInitial());


  getProduct(int id) async {
    emit(ProductLoading());
  final result = await GetProduct(repository: ProductRepoImpl(productDataSource: ProductDataSource(apiServices: ApiServices(Dio())))).call(id);
  result.fold(
    (failure) => emit(ProductError(message: failure.message, title: failure.title)),
    (product) => emit(ProductLoaded(product)),
  );
  }
}
