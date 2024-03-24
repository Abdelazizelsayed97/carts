import 'package:flutter/material.dart';
import 'package:product_cart/core/app_colors/app_colors.dart';
import 'package:product_cart/core/text_styles/app_text_styles.dart';

import '../../../carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

class CartProductSearchDelegate extends SearchDelegate {
  final List<Carts> carts;

  CartProductSearchDelegate(this.carts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Carts> filteredCarts = carts.where((cart) {
      return cart.items.any(
          (item) => item.title!.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    return ListView.builder(

      itemCount: filteredCarts.map((e) => e.items).length,
      itemBuilder: (context, index) {
        final itemTitles =
            filteredCarts[index].items.map((item) => item.title).join(', ');

        final itemPrices =
            filteredCarts[index].items.map((item) => item.price).join(', ');
        return ListTile(
          title: Text(itemTitles),
          subtitle: Text('Prices: $itemPrices'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Carts> filteredCarts = carts.where((cart) {
      return cart.items.any(
          (item) => item.title!.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredCarts.map((e) => e.items).length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            'Cart${filteredCarts[index].cartId.toString()}',
            style: AppTextStyles.bold(fontSize: 20),
          ),
          subtitle: Text(
            filteredCarts[index].items.map((e) => e.title).toString(),
          ),
          onTap: () {
            query = filteredCarts[index].items[index].title ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}
