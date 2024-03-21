import 'package:flutter/material.dart';
import 'package:product_cart/core/helper/spacing.dart';

import '../../../../../../core/text_styles/app_text_styles.dart';
import '../get_carts/widgets/cart_widget.dart';

class CartPreviewFloatingActionButton extends StatelessWidget {
  CartPreviewFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.orange.shade50,
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.orange.shade50.withOpacity(.9),
          context: context,
          builder: (context) => const CartPreviewBottomSheet(),
        );
      },
      child: Icon(
        Icons.shopping_cart,
        color: Colors.black38.withOpacity(.3),
      ),
    );
  }
}

class CartPreviewBottomSheet extends StatefulWidget {
  const CartPreviewBottomSheet();

  @override
  State<CartPreviewBottomSheet> createState() => _CartPreviewBottomSheetState();
}

class _CartPreviewBottomSheetState extends State<CartPreviewBottomSheet> {
  @override
  Widget build(BuildContext context) {
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${CartWidgetBodyState.cartItems}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        verticalSpace(20),
        const Text(
          'Cart Preview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        verticalSpace(20),
        Expanded(
          child: ListView.builder(
            itemCount: CartWidgetBodyState.cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  "${CartWidgetBodyState.cartItems[index].title}",
                  style:
                      AppTextStyles.normal(fontSize: 17, color: Colors.black),
                ),
                subtitle:
                    Text('Price:${CartWidgetBodyState.cartItems[index].price}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    CartWidgetBodyState.cartItems.removeAt(index);
                    setState(() {});
                  },
                  child: Text("Remove"),
                ),
              );
            },
          ),
        ),
        SafeArea(
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.orange.shade100)),
            onPressed: () {},
            child: Text(
              'Checkout',
              style: AppTextStyles.bold(color: Colors.black, fontSize: 17),
            ),
          ),
        ),
      ],
    );
  }
}