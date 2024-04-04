import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/core/text_styles/app_text_styles.dart';
import 'package:product_cart/features/carts/domain/get_all_carts/entities/get_all_carts_entity.dart';

import '../carts_cubit.dart';
import 'cart_widget.dart';

class AddRemoveButton extends StatefulWidget {
  final Function(bool) onPressed;
  final bool isAdded = false;
  final Products element;

  const AddRemoveButton({
    super.key,
    required this.onPressed,
    required this.element,
  });

  @override
  _AddRemoveButtonState createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  late bool _isAdded;
  late List<bool> isInCart;

  @override
  void initState() {
    super.initState();
    _isAdded = widget.isAdded;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isAdded = !_isAdded;
          widget.onPressed(_isAdded);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:  context.read<CartsCubit>().product.contains(widget.element)
            ? Colors.red
            : Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        context.read<CartsCubit>().product.contains(widget.element)

            ? 'Remove from Cart'
            : 'Add to Cart',
        style: AppTextStyles.normal(fontSize: 16,color: Colors.white),
      ),
    );
  }
}

