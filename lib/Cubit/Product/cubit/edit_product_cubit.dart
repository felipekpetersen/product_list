import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:product_list/Cubit/Product/cubit/product_cubit.dart';
import 'package:product_list/Domain/Product/ProductController.dart';
import 'package:product_list/Domain/Product/ProductModel.dart';

part 'edit_product_state.dart';

class DetailProductCubit extends Cubit<DetailProductState> {
  final ProductController _controller;

  DetailProductCubit( this._controller) : super(DetailProductInitial());

  void getSelectedProduct() {
    final product = _controller.getSelectedProduct();
     emit(DetailProductLoaded(product));
  }
}
