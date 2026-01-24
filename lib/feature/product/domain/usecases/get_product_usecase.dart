import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repository/product_repo.dart';

class GetProduct {
 final ProductRepository repository;
  GetProduct({required this.repository});

  Future<Either<Failure, ProductEntity>> call (int id) {
    return repository.getProducts(id);
  }

}