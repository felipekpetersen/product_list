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
  return Scaffold(
    appBar: AppBar(),
    body: Center(
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
                  Text('Products', style: TITLE_STYLE,),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Add product',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Expanded( 
                child: ListView.builder(
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
    ),
  );
}

Widget _product(ProductsModel product, context) {
  return InkWell(
    onTap: () {
      // BlocProvider.of<EditProductCubit>(context).selectProduct(product);
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
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(product.image ?? ''), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8)),
        ),
        SizedBox(width: 24,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title ?? "No Title",
                style: PRODUCT_TITLE_STYLE,
              ),
              Text(product.description ?? "No Description", style: PRODUCT_DESCRIPTION_STYLE, maxLines: 3, overflow: TextOverflow.ellipsis,),
              product.price != null ? Text(product.price!.toPrice(), style: PRODUCT_PRICE_STYLE,) : Text('No Price', style: PRODUCT_PRICE_STYLE,),
            ],
          ),
        ),
      ],
    ),
  );
}
