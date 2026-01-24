import '../../domain/entities/product_entity.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductEntity product;

  ProductLoaded(this.product);
}

class ProductError extends ProductState {
  final String message;
  final String? title;

  ProductError({required this.message, this.title});
}
