import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Domain/Product/ProductModel.dart';

class ProductRepo {
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
}
