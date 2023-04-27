import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Common/Constants.dart';
import 'package:product_list/Common/Extensions.dart';
import 'package:product_list/Common/TextStyle.dart';
import 'package:product_list/Cubit/Cart/cubit/cart_cubit.dart';

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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CART_ROUTE);
              },
              icon: Icon(Icons.shopping_cart))
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        if (state is ProductInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductLoaded) {
          return _buildProductScreen(context, state);
        } else if (state is ProductError) {
          return Text(state.error);
        } else {
          return const Placeholder();
        }
      }),
    );
  }
}

Widget _buildProductScreen(context, state) {
  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200, maxHeight: double.infinity),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Products',
                  style: TITLE_STYLE,
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     crossAxisSpacing: 16,
                //     mainAxisSpacing: 16,
                //     childAspectRatio: 0.8),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return _product(state.products[index], context);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _product(ProductsModel product, context) {
  return InkWell(
    onTap: () {
      BlocProvider.of<ProductCubit>(context).selectProduct(product);
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
      borderRadius: BorderRadius.circular(8),
      color: Colors.white
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Image.network(
                product.image ?? '',
                // width: 100,
                // height: 100,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Text(product.title ?? '', style: PRODUCT_TITLE_STYLE, maxLines: 2, overflow: TextOverflow.ellipsis,),
        SizedBox(height: 8,),
        Text(product.price?.toPrice() ?? '', style: PRODUCT_DESCRIPTION_STYLE),
        SizedBox(height: 8,),
        _addToCartButton(product)
      ],
    ),
  );
}

// Widget _productTile(ProductsModel product) {
//   return Container(
//     margin: EdgeInsets.all(8),
//     padding: EdgeInsets.all(8),
//     decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8)),
//     child: Row(
//       children: [
//         Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: NetworkImage(product.image ?? ''), fit: BoxFit.cover),
//               borderRadius: BorderRadius.circular(8)),
//         ),
//         SizedBox(
//           width: 24,
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 product.title ?? "No Title",
//                 style: PRODUCT_TITLE_STYLE,
//               ),
//               Text(
//                 product.description ?? "No Description",
//                 style: PRODUCT_DESCRIPTION_STYLE,
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               product.price != null
//                   ? Text(
//                       product.price!.toPrice(),
//                       style: PRODUCT_PRICE_STYLE,
//                     )
//                   : Text(
//                       'No Price',
//                       style: PRODUCT_PRICE_STYLE,
//                     ),
//             ],
//           ),
//         ),
//         _addToCartButton(product)
//       ],
//     ),
//   );
// }

Widget _addToCartButton(ProductsModel product) {
  return BlocBuilder<CartCubit, CartState>(
    builder: (context, state) {
      BlocProvider.of<CartCubit>(context).getProducts();
      if (state is CartLoading) {
        return CircularProgressIndicator();
      }
      if (state is CartLoaded) {
        final inCart =
            state.products.any((element) => element.id == product.id);
        return Center(
          child: InkWell(
            onTap: () {
              inCart
                  ? null
                  : BlocProvider.of<CartCubit>(context).addToCart(product);
            },
            child: Container(
              // width: 100,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  inCart ? 'Added' : 'Add to Cart',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      } else {
        return const Placeholder();
      }
    },
  );
}
