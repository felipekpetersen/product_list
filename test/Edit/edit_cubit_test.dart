import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/Cubit/Product/cubit/edit_product_cubit.dart';
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
    var model = ProductsModel();

    setUp(() {
      productRepoTest = ProductRepoTest();
      productControllerTest = ProductController(productRepoTest);
      productController = ProductController(ProductRepo());
    });

    test('inital state detail product cubit', () {
      expect(DetailProductCubit(productControllerTest).state,
          DetailProductInitial());
    });

    blocTest<DetailProductCubit, DetailProductState>(
      'emits DetailProductLoaded when getSelectedProduct is added.',
      setUp: () {
        model = ProductsModel(
          id: 1,
          title: 'title',
          price: 1,
          description: 'description',
          category: 'category',
          image: 'image',
        );
        productController.selectProduct(model);
      },
      build: () => DetailProductCubit(productController),
      act: (bloc) {
        bloc.getSelectedProduct();
      },
      expect: () => <DetailProductState>[DetailProductLoaded(model)],
    );
  });
}
