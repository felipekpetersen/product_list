part of 'edit_product_cubit.dart';

@immutable
abstract class DetailProductState extends Equatable {}

class DetailProductInitial extends DetailProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DetailProductLoaded extends DetailProductState {
  final ProductsModel product;

  DetailProductLoaded(this.product);
  
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}

class DetailProductError extends DetailProductState {
  final String error;

  DetailProductError(this.error);
  
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
