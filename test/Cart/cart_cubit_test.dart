import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_list/Cubit/Cart/cubit/cart_cubit.dart';
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

    test('inital state Cart cubit', () {
      expect(CartCubit(productControllerTest).state, CartInitial());
    });

    blocTest<CartCubit, CartState>(
      'emits [CartLoading, CartLoaded([products])] when addToCart is added.',
      setUp: () {
        model = ProductsModel(
          id: 1,
          title: 'title',
          price: 1,
          description: 'description',
          category: 'category',
          image: 'image',
        );
      },
      build: () => CartCubit(productController),
      act: (bloc) {
        bloc.addToCart(model);
      },
      expect: () => <CartState>[
        CartLoading(),
        CartLoaded([model])
      ],
    );

    blocTest<CartCubit, CartState>(
      'emits [CartLoading, CartLoaded([])] when getproducts is added. Empty list',
      build: () => CartCubit(productController),
      act: (bloc) {
        bloc.getProducts();
      },
      expect: () => <CartState>[CartLoading(), CartLoaded([])],
    );

    blocTest<CartCubit, CartState>(
      'emits [CartLoading, CartLoaded([products])] when getproducts is added. not empty list',
      setUp: () {
        model = ProductsModel(
          id: 1,
          title: 'title',
          price: 1,
          description: 'description',
          category: 'category',
          image: 'image',
        );
        productController.addToCart(model);
      },
      build: () => CartCubit(productController),
      act: (bloc) {
        bloc.getProducts();
      },
      expect: () => <CartState>[CartLoading(), CartLoaded([model])],
    );
  });
}

