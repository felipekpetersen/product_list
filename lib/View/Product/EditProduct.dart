import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Common/Constants.dart';
import 'package:product_list/Common/Extensions.dart';
import 'package:product_list/Cubit/Product/cubit/edit_product_cubit.dart';

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

    return Scaffold(
      appBar: AppBar(),
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
                buildDetailBox(state.product)
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildDetailBox(ProductsModel product) {
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
                  Text(product.title ?? "No Title"),
                  Text((product.price ?? 0.0).toPrice()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Sobre"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.description ?? "No Description"),
            ),
            Expanded(child: Container(),),
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(16),
                // height: 16,
                // width: 16,
                decoration: BoxDecoration(color: Colors.black,
                borderRadius: BorderRadius.circular(8)),
                child: Text("Add to cart", style: TextStyle(color: Colors.white),
                )
              ),
            )
          ],
        )),
  );
}
