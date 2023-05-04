import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Common/TextStyle.dart';
import 'package:product_list/Cubit/Cart/cubit/cart_cubit.dart';
import 'package:product_list/Domain/Product/ProductModel.dart';
import 'package:product_list/Common/Extensions.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartCubit>(context).getProducts();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Carrinho'),
        ),
        body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          if (state is CartInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return _productTile(state.products[index]);
              },
            );
          } else {
            return const Placeholder();
          }
        }));
  }
}

Widget _productTile(ProductsModel product) {
  return Container(

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    margin: EdgeInsets.all(8),
    child: Row(children: [
      Image.network(
        product.image ?? '',
        width: 100,
        height: 100,
      ),
      Flexible(
        child: Container(
          padding: EdgeInsets.fromLTRB(4,4,8,4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: PRODUCT_TITLE_STYLE,),
              Text(product.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: PRODUCT_DESCRIPTION_STYLE,),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.delete),
            // ),
            Text(product.price?.toPrice() ?? '', style: PRICE_STYLE),
          ],
        ),
      )
    ]),
  );
}

// Widget _detailProduct() {

// }
