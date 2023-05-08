part of 'product_cubit.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductInitial extends ProductState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<ProductsModel> products;

  ProductLoaded(this.products);
  
  @override
  // TODO: implement props
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
  
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}


