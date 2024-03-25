import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/core/app_colors/app_colors.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';

import 'button_widget.dart';

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
      CartWidgetBodyState(products: carts, text: text, indexed: indexed);
}

class CartWidgetBodyState extends State<CartWidgetBody> {
  final List<Carts> products;
  final int indexed;
  final String text;
  final ExpansionTileController controller = ExpansionTileController();
  static List<Products> cartItems = [];

  CartWidgetBodyState(
      {required this.indexed, required this.text, required this.products});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          collapsedBackgroundColor: ColorsManger.primaryColor,
          backgroundColor: ColorsManger.secondaryColor,
          title: Text('Cart $text'),
          children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(products[indexed]
                              .items[index]
                              .thumbnail
                              .toString()),
                        ),
                      ),
                      trailing: AddRemoveButton(
                        element: products[indexed].items[index],
                        onPressed: (bool) {
                          setState(() {
                            CartWidgetBodyState.cartItems
                                    .contains(products[indexed].items[index])
                                ? context.read<CartsCubit>().removeFromCart(
                                    products[indexed].items[index])
                                : context
                                    .read<CartsCubit>()
                                    .addToCart(products[indexed].items[index]);
                          });
                          setState(() {});
                        },
                      ),
                      subtitle:
                          Text(products[indexed].items[index].title ?? ""));
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(20);
                },
                itemCount: products[indexed].items.length),
          ],
        ));
  }
}
