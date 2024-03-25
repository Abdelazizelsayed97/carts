import 'package:flutter/material.dart';
import 'package:product_cart/core/app_colors/app_colors.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/core/text_styles/app_text_styles.dart';
import 'package:product_cart/features/search/ui/widgets/preview_product.dart';

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
        (item) => item.title!.toLowerCase().contains(query.toLowerCase()),
      );
    }).toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredCarts.length,
      itemBuilder: (context, index) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: filteredCarts[index].items.length,
          itemBuilder: (context, itemIndex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    horizontalSpace(15),
                    Text('Cart num: ${filteredCarts[index].cartId}', style: AppTextStyles.bold(fontSize: 18),),
                  ],
                ),
                Card(
                  borderOnForeground: true,
                  child: ListTile(
                    title:
                        Text(filteredCarts[index].items[itemIndex].title ?? ''),
                    subtitle: Text(
                        'price: ${filteredCarts[index].items[itemIndex].price.toString()}'),
                    trailing: Image.network(filteredCarts[index]
                        .items[itemIndex]
                        .thumbnail
                        .toString()),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviewProducts(
                                    product:
                                        filteredCarts[index].items[itemIndex],
                                  )));

                    },
                  ),
                ),
              ],
            );
          },
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
      itemCount: filteredCarts.length,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) => ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: filteredCarts[index].items.length,
        itemBuilder: (context, itemIndex) {
          return Card(
            color: ColorsManger.primaryColor,
            child: ListTile(
              title: Text(
                'Cart${filteredCarts[index].cartId.toString()}',
                style: AppTextStyles.bold(fontSize: 20),
              ),
              subtitle: Text(
                filteredCarts[index].items[itemIndex].title.toString(),
              ),
              onTap: () {
                query = filteredCarts[index].items[itemIndex].title ?? '';
                showResults(context);
              },
            ),
          );
        },
      ),
    );
  }
}
