import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:product_list/Domain/Product/ProductController.dart';

import '../../../Domain/Product/ProductModel.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductController _controller;

  ProductCubit(this._controller) : super(ProductInitial());

  void getProducts() {
    try {
      _controller.getProducts().then((value) => emit(ProductLoaded(value)));
    } catch (err) {
      emit(ProductError(err.toString()));
    }
  }

  // void selectProduct(ProductsModel product) {
  //   emit(ProductSelected(product));
  // }
}
