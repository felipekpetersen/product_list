import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Common/Constants.dart';
import 'package:product_list/Common/TextStyle.dart';

import '../../Cubit/Product/cubit/edit_product_cubit.dart';
import '../../Cubit/Product/cubit/product_cubit.dart';
import '../../Domain/Product/ProductModel.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).getProducts();

    return Scaffold(
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state is ProductInitial) {
          return const Placeholder();
        } else if (state is ProductLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return _product(state.products[index], context);
            },
          );
        } else if (state is ProductError) {
          return Text(state.error);
        } else {
          return const Placeholder();
        }
      }),
    );
  }
}

Widget _product(ProductsModel product, context) {
  return InkWell(
    onTap: () {
      BlocProvider.of<EditProductCubit>(context).selectProduct(product);
      Navigator.pushNamed(context, EDIT_PRODUCT_ROUTE);

    },
    child: _productTile(product),
  );
}

Widget _productTile(ProductsModel product) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title!,
          style: TITLE_STYLE,
        ),
        Text(product.description!, style: DESCRIPTION_STYLE),
      ],
    ),
  );
}
