import '../../../../global_imports.dart';
import '../../domain/usecases/get_product_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProduct _getProduct;

  ProductCubit({required GetProduct getProduct})
      : _getProduct = getProduct,
        super(ProductInitial());

  Future<void> getProduct(int id) async {
    emit(ProductLoading());
    final result = await _getProduct.call(id);
    result.fold(
      (failure) => emit(ProductError(message: failure.message, title: failure.title)),
      (product) => emit(ProductLoaded(product)),
    );
  }
}
