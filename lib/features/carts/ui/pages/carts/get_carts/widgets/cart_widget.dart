import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/core/app_colors/app_colors.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_entity.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';

import '../../../../../../../core/helper/spacing.dart';
import 'button_widget.dart';

class CartWidgetBody extends StatefulWidget {
  final List<Carts> carts;
  final String text;
  final int indexed;

  const CartWidgetBody({
    super.key,
    required this.carts,
    required this.text,
    required this.indexed,
  });

  @override
  State<CartWidgetBody> createState() => CartWidgetBodyState();
}

class CartWidgetBodyState extends State<CartWidgetBody> {
  late final ExpansionTileController controller;
  static List<Products> cartItems = [];

  @override
  void initState() {
    super.initState();
    controller = ExpansionTileController(); // Initialize the controller
  }

  void addAndRemove(Products product) {
    BlocProvider.of<CartsCubit>(context).addAndRemoveFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(19)),
      ),
      child: ExpansionTile(
        controller: controller,
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(19)),
        ),
        collapsedShape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(19)),
        ),
        collapsedBackgroundColor: ColorsManger.primaryColor,
        backgroundColor: ColorsManger.secondaryColor,
        title: Text('Cart ${widget.text}'),
        children: [
          Column(
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
                        backgroundImage: NetworkImage(
                          widget.carts[widget.indexed].items[index].thumbnail
                              .toString(),
                        ),
                      ),
                    ),
                    trailing: AddRemoveButton(
                      element: widget.carts[widget.indexed].items[index],
                      onPressed: (bool bool) {
                        setState(() {
                          addAndRemove(
                              widget.carts[widget.indexed].items[index]);
                        });
                        setState(() {});
                      },
                    ),
                    subtitle: Text(
                      widget.carts[widget.indexed].items[index].title ?? "",
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(20);
                },
                itemCount: widget.carts[widget.indexed].items.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
