import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/Cubit/Product/cubit/product_cubit.dart';
import 'package:product_list/Domain/Product/ProductController.dart';
import 'package:product_list/Domain/Product/ProductModel.dart';
import 'package:product_list/Repository/Product/product_repo.dart';

// class ProductControllerTest extends Mock implements ProductController {
//   ProductControllerTest(ProductRepo) : super();
// }

class ProductRepoTest extends Mock implements ProductRepo {}

void main() {
  group('ProductCubit', () {
    late ProductController productControllerTest;
    late ProductRepoTest productRepoTest;
    late ProductController productController;
    final model = [ProductsModel()];
    var product = ProductsModel();

    setUp(() {
      productRepoTest = ProductRepoTest();
      productControllerTest = ProductController(productRepoTest);
      productController = ProductController(ProductRepo());
    });

    test('inital state product cubit', () {
      expect(ProductCubit(productControllerTest).state, ProductInitial());
    });

    blocTest<ProductCubit, ProductState>(
      'emits ProductLoaded when getProducts is added.',
      setUp: () {
        when(productRepoTest.getProducts()).thenAnswer((_) async {
          return model;
        });
      },
      build: () => ProductCubit(productControllerTest),
      act: (bloc) {
        bloc.getProducts();
      },
      expect: () => <ProductState>[ProductLoaded(model)],
    );
  });
}
