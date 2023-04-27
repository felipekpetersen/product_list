import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list/Cubit/Cart/cubit/cart_cubit.dart';

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
          title: const Text('Cart'),
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
            return ListTile(
              title: Text(state.products[index].title ?? ''),
              subtitle: Text(state.products[index].description ?? ''),
              trailing: IconButton(
                onPressed: () {
                  // context
                  //     .read<CartCubit>()
                  //     .removeFromCart(state.cartProducts[index]);
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
        );
      } else {
        return const Placeholder();
      }
    }));
  }
}
