import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Common/Common_Widgets.dart';
import 'package:product_list/Common/Constants.dart';
import 'package:product_list/Common/Extensions.dart';
import 'package:product_list/Cubit/Cart/cubit/cart_cubit.dart';
import 'package:product_list/Cubit/Product/cubit/edit_product_cubit.dart';

import '../../Common/TextStyle.dart';
import '../../Domain/Product/ProductModel.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({Key? key}) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailProductCubit>(context).getSelectedProduct();
    BlocProvider.of<CartCubit>(context).getProducts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Detalhes"),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<DetailProductCubit, DetailProductState>(
          builder: (context, state) {
        if (state is DetailProductInitial)
          return const Center(
            child: CircularProgressIndicator(),
          );
        else if (state is DetailProductLoaded)
          return _buildDetailScreen(context, state);
        else if (state is DetailProductError)
          return Text(state.error);
        else {
          return const Placeholder();
        }
      }),
    );
  }
}

Widget _buildDetailScreen(context, DetailProductLoaded state) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      constraints: BoxConstraints(maxWidth: 1200, maxHeight: double.infinity),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Center(
                  child: Image.network(
                    state.product.image!,
                    width: 300,
                    height: 300,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                buildDetailBox(state)
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildDetailBox(DetailProductLoaded state) {
  return Expanded(
    child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.product.title ?? "No Title",
                    style: PRODUCT_TITLE_STYLE,
                  ),
                  Text(
                    (state.product.price ?? 0.0).toPrice(),
                    style: PRICE_STYLE,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Sobre",
                style: ABOUT_DETAIL_STYLE,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
              child: Text(state.product.description ?? "No Description"),
            ),
            Expanded(
              child: Container(),
            ),
            Center(child: _cartButton(state.product))
          ],
        )),
  );
}

Widget _cartButton(ProductsModel product) {
  
  return BlocBuilder<CartCubit, CartState>(
    builder: (context, state) {
      if (state is CartInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CartLoaded) {
        final inCart =
            state.products.any((element) => element.id == product.id);
        return cartButton(inCart, () {
          if (!inCart) {
            BlocProvider.of<CartCubit>(context).addToCart(product);
          }
        });
      }
      return Container();
    },
  );
}
