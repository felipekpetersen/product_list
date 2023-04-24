part of 'edit_product_cubit.dart';

@immutable
abstract class DetailProductState {}

class DetailProductInitial extends DetailProductState {}

class DetailProductLoaded extends DetailProductState {
  final ProductsModel product;

  DetailProductLoaded(this.product);
}

class DetailProductError extends DetailProductState {
  final String error;

  DetailProductError(this.error);
}

