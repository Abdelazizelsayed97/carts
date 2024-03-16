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
  late final List xx;

  final String text;

  bool selected = false;

  _CartWidgetBodyState(
      {required this.indexed, required this.text, required this.products});

  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: ExpansionTile(
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(19),
            ),
          ),
          collapsedShape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(19))),
          collapsedBackgroundColor: Colors.grey.shade400,
          backgroundColor: Colors.grey.shade300,
          title: Text('Cart $text'),
          children: [
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: Image.network(
                            scale: 10,
                            fit: BoxFit.cover,
                            products[indexed].items[index].thumbnail ?? ''),
                      ),
                      trailing: TextButton(
                        onPressed: () {
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
                itemCount: products.first.items.length),
          ],
        ));
  }
}
