import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/core/text_styles/app_text_styles.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

import '../../../carts/ui/pages/carts/get_carts/carts_cubit.dart';
import '../../../carts/ui/pages/carts/get_carts/widgets/button_widget.dart';
import '../../../carts/ui/pages/carts/get_carts/widgets/cart_widget.dart';

class PreviewProducts extends StatelessWidget {
  const PreviewProducts({super.key, required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ''),
      ),
      body: Column(
        children: [
          Image.network(product.thumbnail ?? ''),
          ListTile(
            title: Text(
              'Buy now and get discount up to ${product.discountPercentage}%',
              style: AppTextStyles.semiBold(
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              'Price : ${product.price} LE',
              style:
                  AppTextStyles.normal(color: Colors.grey[600], fontSize: 14),
            ),
             trailing: AddRemoveButton(onPressed: (bool ) {
               CartWidgetBodyState.cartItems
                   .contains(product)
                   ? context.read<CartsCubit>().removeFromCart(
                   product)
                   : context
                   .read<CartsCubit>()
                   .addToCart(product);
             }, element: product,)
          ),
        ],
      ),
    );
  }
}
