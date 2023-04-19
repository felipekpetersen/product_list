import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Cubit/Product/cubit/edit_product_cubit.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<EditProductCubit>(context).selectedProduct();

    return Scaffold(
      body: BlocBuilder<EditProductCubit, EditProductState>(
          builder: (context, state) {
            if(state is EditProductInitial)
              return const Placeholder();
            else if(state is EditProductLoaded)
              return Text(state.product.title!);
            // else if(state is EditProductError)
            //   return Text(state.error);
            else {
              return const Placeholder();
            }
            
          }),
    );
  }
}
