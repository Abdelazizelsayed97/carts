import 'package:flutter/material.dart';

import '../../../carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

class CartProductSearchDelegate extends SearchDelegate {
  // List of carts
  final List<Carts> carts;

  List<Carts> filteredCarts = [];

  CartProductSearchDelegate(this.carts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
          filteredCarts.clear();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Enter a search term'));
    }

    filteredCarts = carts
        .where((cart) => carts.map((e) => e.items).any((product) => product
            .map((product) => product.title)
            .toList()
            .contains(query.toLowerCase())))
        .toList();

    return ListView.builder(
      itemCount: filteredCarts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title:
              Text(filteredCarts[index].items.map((e) => e.title).toString()),
          // Assuming Cart has a name property
          subtitle: Text('Products: ${filteredCarts[index].items.length}'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Search suggestions'));
  }
}
