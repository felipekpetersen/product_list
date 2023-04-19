import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:product_list/Cubit/Product/cubit/product_cubit.dart';
import 'package:product_list/Domain/Product/ProductController.dart';
import 'package:product_list/Domain/Product/ProductModel.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  final ProductController _controller;

  EditProductCubit( this._controller) : super(EditProductInitial());

   void selectProduct(ProductsModel product) {
    emit(EditProductLoaded(product));
  }
}
