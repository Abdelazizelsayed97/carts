import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';

import '../../../../../../core/di/app_di.dart';
import '../../../../../../core/text_styles/app_text_styles.dart';
import '../get_carts/widgets/cart_widget.dart';

class CartPreviewFloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;

  const CartPreviewFloatingActionButton({
    super.key,
    required this.onTap,
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
    return BlocProvider(
      create: (context) => CartsCubit(inject()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          verticalSpace(20),
          Text(
            'Cart',
            style: AppTextStyles.bold(fontSize: 24),
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
                  subtitle: Text(
                      'Price:${CartWidgetBodyState.cartItems[index].price}',
                      style: AppTextStyles.normal(
                          fontSize: 16, color: Colors.grey)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      context
                          .read<CartsCubit>()
                          .removeFromCart(CartWidgetBodyState.cartItems[index]);
                      setState(() {});
                    },
                    child: Text(
                      "Remove",
                      style:
                          AppTextStyles.normal(fontSize: 16, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.orange.shade100),
              ),
              onPressed: () {},
              child: Text(
                'Checkout',
                style: AppTextStyles.bold(color: Colors.black, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
