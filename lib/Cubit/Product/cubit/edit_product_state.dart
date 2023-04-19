part of 'edit_product_cubit.dart';

@immutable
abstract class EditProductState {}

class EditProductInitial extends EditProductState {}

class EditProductLoaded extends EditProductState {
  final ProductsModel product;

  EditProductLoaded(this.product);
}

