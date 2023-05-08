import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_list/Domain/Product/ProductController.dart';
import 'package:product_list/Repository/Product/product_repo.dart';

import '../../../Domain/Product/ProductModel.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  ProductController _controller;

  CartCubit(this._controller) : super(CartInitial());

  // void startCart() {
  //   emit(CartInitial());
  // }

  void getProducts() async {
    emit(CartLoading());
    List<ProductsModel> products = _controller.getCartProducts();
    emit(CartLoaded(products));
  }

  void addToCart(ProductsModel product) {
    _controller.addToCart(product);
    getProducts();
  }
}
