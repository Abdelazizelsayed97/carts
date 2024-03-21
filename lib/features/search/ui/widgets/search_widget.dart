import 'package:flutter/material.dart';

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
      itemCount: filteredCarts.length,
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
      itemCount: filteredCarts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredCarts[index].items[index].title ?? ''),
          onTap: () {
            query = filteredCarts[index].items[index].title ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}
