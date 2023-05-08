part of 'cart_cubit.dart';

@immutable
abstract class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<ProductsModel> products;

  CartLoaded(this.products);

  @override
  // TODO: implement props
  List<Object?> get props => [products];
}
