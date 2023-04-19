import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:product_list/locator.dart';

import '../../Repository/Product/product_repo.dart';
import 'ProductModel.dart';

class ProductController {
  final ProductRepo _repo;

  ProductController(this._repo);

  Future<List<ProductsModel>> getProducts() async {
    return await _repo.getProducts();
  }

  // void selectProduct(ProductsModel product) {
  //   locator<ProductRepo>().selectProduct(product);
  // }
}
