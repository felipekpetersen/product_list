import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Domain/Product/ProductModel.dart';

class ProductRepo {
  ProductsModel selectedProduct = ProductsModel();
  List<ProductsModel> cartProducts = [];

  getProducts() async {
    var response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var data = [];
      final List<dynamic> decodedJson = jsonDecode(response.body);
      data = decodedJson.map((e) => ProductsModel.fromJson(e)).toList();
      return data;
      
    } else {
      throw Exception('Failed to load products');
    }
  }

  selectProduct(ProductsModel product) {
    selectedProduct = product;
  }

  getSelectedProduct() {
    return selectedProduct;
  }

  getCartProducts() {
    return cartProducts;
  }

  addToCart(ProductsModel product) {
    cartProducts.add(product);
  }

  removeFromCart(ProductsModel product) {
    cartProducts.remove(product);
  }
}
