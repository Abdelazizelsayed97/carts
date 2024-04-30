import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_entity.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';

import '../../../../../../core/di/app_di.dart';
import '../../../../../../core/text_styles/app_text_styles.dart';

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
  const CartPreviewBottomSheet({super.key});

  @override
  State<CartPreviewBottomSheet> createState() => _CartPreviewBottomSheetState();
}

class _CartPreviewBottomSheetState extends State<CartPreviewBottomSheet> {
  void addAndRemoveProduct(Products product) {
    context.read<CartsCubit>().addAndRemoveFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    print(
        'HHHHHHHHHHHHHHHHHHHHHHH>>>>${BlocProvider.of<CartsCubit>(context).product.length}');
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
              shrinkWrap: true,
              // shrinkWrap: true,
              itemCount: context.read<CartsCubit>().product.length,
              itemBuilder: (context, index) {
                print(
                    'this is cubit product list ${context.read<CartsCubit>().product}');
                final selectedItems = context.read<CartsCubit>().product;
                return ListTile(
                  title: Text(
                    selectedItems[index].title ?? '',
                    style:
                        AppTextStyles.normal(fontSize: 17, color: Colors.black),
                  ),
                  subtitle: Text(
                    'Price:${selectedItems[index].price}',
                    style:
                        AppTextStyles.normal(fontSize: 16, color: Colors.grey),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      addAndRemoveProduct(selectedItems[index]);
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
