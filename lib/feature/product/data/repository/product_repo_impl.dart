
import '../../../../global_imports.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/product_repo.dart';
import '../datasource/product_data_source.dart';

class ProductRepoImpl implements ProductRepository {
  final ProductDataSource productDataSource;
  ProductRepoImpl({required this.productDataSource});

  @override
  Future<Either<Failure, ProductEntity>> getProducts(int id) async {
    try {
      final product = await productDataSource.getProducts(id);
      return right(product);
    } on DioException catch (e, t) {
      return handleRepoDataError(e, t);
    } catch (e, t) {
      return handleRepoDataError(e, t);
    }
  }
}
 