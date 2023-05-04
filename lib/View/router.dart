
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Cubit/Cart/cubit/cart_cubit.dart';
import 'package:product_list/Cubit/Product/cubit/edit_product_cubit.dart';
import 'package:product_list/Cubit/Product/cubit/product_cubit.dart';
import 'package:product_list/Domain/Product/ProductController.dart';
import 'package:product_list/View/Cart/cart.dart';

import '../Common/Constants.dart';
import '../locator.dart';
import 'Product/EditProduct.dart';
import 'Product/ProductList.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(

            builder: (_) => MultiBlocProvider(providers: 
            [
              BlocProvider(create: (context) => ProductCubit(locator<ProductController>())),
              BlocProvider(create: (context) => CartCubit(locator<ProductController>())),
            ],
            child: ProductList())
                );
      case EDIT_PRODUCT_ROUTE:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: 
            [
              BlocProvider(create: (context) => DetailProductCubit(locator<ProductController>())),
              BlocProvider(create: (context) => CartCubit(locator<ProductController>())),
            ],
                  child: DetailProduct(),
                ));

       case CART_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => CartCubit(
                       locator<ProductController>()),
                  child: CartWidget(),
                ));
    
      default:
        return null;
    }
  }
}
