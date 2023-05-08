import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/Domain/Product/ProductController.dart';
import 'package:product_list/Domain/Product/ProductModel.dart';
import 'package:product_list/Repository/Product/product_repo.dart';
import 'package:http/http.dart' as http;

import 'product_repo_test.mocks.dart';

class ProductRepoTest extends Mock implements ProductRepo {}

@GenerateMocks([http.Client])
void main() {
  group('productRepo', () {
    late ProductRepoTest productRepoTest;
    late ProductController productControllerTest;
    late ProductRepo productRepo;
    late ProductController productController;

    setUp(() {
      productRepoTest = ProductRepoTest();
      productControllerTest = ProductController(productRepoTest);
      productRepo = ProductRepo();
      productController = ProductController(productRepo);
    });

    group('getProducts', () {
      test('returns list of products', () async {
        var model = [ProductsModel()];

        when(productRepoTest.getProducts()).thenAnswer((_) async {
          return model;
        });

        final resController = await productControllerTest.getProducts();
        final res = await productRepoTest.getProducts();

        expect(res, isA<List<ProductsModel>>());
        expect(res, model);
        expect(resController, model);
      });
    });

    group('selectProduct', () {
      test('selects a product and return the selected product', () async {
        final model = ProductsModel(
          id: 1,
          title: 'title',
          price: 1,
          description: 'description',
          category: 'category',
          image: 'image',
        );
        productRepo.selectProduct(model);
        productController.selectProduct(model);

        expect(productRepo.getSelectedProduct(), equals(model));
        expect(productController.getSelectedProduct(), equals(model));
      });

    });

    group('Cart', () {
      test('adds a product to the cart', () async {
        final model = ProductsModel(
          id: 1,
          title: 'title',
          price: 1,
          description: 'description',
          category: 'category',
          image: 'image',
        );
        productRepo.addToCart(model);
        productController.addToCart(model);

        expect(productRepo.getCartProducts(), contains(model));
        expect(productController.getCartProducts(), contains(model));
      });

      test('removes a product from the cart', () async {
        final model = ProductsModel(
          id: 1,
          title: 'title',
          price: 1,
          description: 'description',
          category: 'category',
          image: 'image',
        );
        productRepo.addToCart(model);
        productRepo.removeFromCart(model);
        productController.addToCart(model);
        productController.removeFromCart(model);

        expect(productRepo.getCartProducts(), isNot(contains(model)));
        expect(productController.getCartProducts(), isNot(contains(model)));
      });
    });
  });
}
