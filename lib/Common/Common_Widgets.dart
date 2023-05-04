import 'package:flutter/material.dart';

//cartButton
Widget cartButton(isAddedToCart, Function() addToCart) {
  return Container(
    // padding: EdgeInsets.all(4),
    margin: EdgeInsets.all(4),
    height: 40,
    width: 90,
    decoration: BoxDecoration(
      color: isAddedToCart ? Colors.white : Colors.black,
      borderRadius: BorderRadius.circular(10),
      border: isAddedToCart ?Border.all(
        color: Colors.black,
        width: 2,) : null
    ),
    child: IconButton(
      icon: Icon(
        isAddedToCart ? Icons.check : Icons.shopping_cart,
        color: isAddedToCart ? Colors.black : Colors.white,
        size: 25,
      ),
      onPressed: () {
        addToCart();
      },
    ),
  );
}