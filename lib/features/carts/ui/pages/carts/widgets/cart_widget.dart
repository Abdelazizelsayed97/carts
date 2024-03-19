import 'package:flutter/material.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

class CartWidgetBody extends StatefulWidget {
  final List<Carts> carts;
  final String text;
  final int indexed;

  const CartWidgetBody(
      {super.key,
      required this.carts,
      required this.text,
      required this.indexed});

  @override
  State<CartWidgetBody> createState() =>
      _CartWidgetBodyState(products: carts, text: text, indexed: indexed);
}

class _CartWidgetBodyState extends State<CartWidgetBody> {
  final List<Carts> products;
  final int indexed;
  final String text;
  bool selected = false;

  _CartWidgetBodyState(
      {required this.indexed, required this.text, required this.products});

  List<Products> cartItems = [];

  void addToCart(Products item) {
    setState(() {
      cartItems.add(item);
    });
  }

  void removeFromCart(Products item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('???##########################${cartItems}');
    return Container(
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(19))),
        child: ExpansionTile(
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(19),
            ),
          ),
          collapsedShape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(19))),
          collapsedBackgroundColor: Colors.black26,
          backgroundColor: Colors.yellow[50],
          title: Text('Cart $text'),
          children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: Image.network(
                            scale: 10,
                            fit: BoxFit.cover,
                            products[indexed]
                                    .items[index]
                                    .thumbnail
                                    .toString() ??
                                ''),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          if (selected = false) {
                            addToCart(products[indexed].items[index]);
                          } else {
                            removeFromCart(products[indexed].items[index]);
                          }
                          selected != selected;
                          setState(() {});
                        },
                        child: Text(
                          (selected = false) ? "Remove" : 'Add',
                          style: TextStyle(
                              color: (selected = false)
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                      subtitle:
                          Text(products[indexed].items[index].title ?? ""));
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(20);
                },
                itemCount: 5
                // products.first.items.length
            ),
          ],
        ));
  }
  // Widget builds(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Shopping Cart'),
  //     ),
  //     body: ListView.builder(
  //       itemCount: cartItems.length,
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           title: Text(cartItems[index].title ?? ""),
  //           trailing: IconButton(
  //             icon: const Icon(Icons.remove_shopping_cart),
  //             onPressed: () {
  //               removeFromCart(cartItems[index]);
  //             },
  //           ),
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         addToCart("Item ${cartItems.length + 1}" as Products);
  //       },
  //       child: Icon(Icons.add),
  //     ),
  //   );
  // }
}
