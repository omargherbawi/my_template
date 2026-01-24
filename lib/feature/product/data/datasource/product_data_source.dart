import '../../../../core/services/api.service.dart';
import '../../../../global_imports.dart';
import '../endpoints/product_end_points.dart';
import '../model/product_model.dart';

class ProductDataSource {
final ApiServices apiServices;

  ProductDataSource({required this.apiServices});

  Future<ProductModel> getProducts(int id) async {

   final response = await apiServices.getData('${ProductEndpoint.getProducts}/$id');
   return ProductModel.fromJson(response);
  }
}