import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Common/Constants.dart';
import 'package:product_list/Cubit/Product/cubit/edit_product_cubit.dart';

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

Widget _buildDetailScreen(context,DetailProductLoaded state) {
  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1200, maxHeight: double.infinity),
      child: Column(
        children: [
          Center(
            child: Image.network(
              state.product.image!,
              width: 300,
              height: 300,
            ),
          ),
          Text(state.product.title ?? "No Title"),
          Text((state.product.price ?? 0.0).toPrice()),
          Text(state.product.description ?? "No Description"),
        ],
      ),
    ),
  );
}
