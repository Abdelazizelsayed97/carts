import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/core/app_colors/app_colors.dart';
import 'package:product_cart/core/text_styles/app_text_styles.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';
import 'package:product_cart/features/search/ui/widgets/preview_product.dart';

import '../../../carts/domain/get_all_carts/entities/get_all_carts_entity.dart';

class CartProductSearchDelegate extends SearchDelegate {
  final List<Carts> carts;

  CartProductSearchDelegate(this.carts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
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
    List<Products> matchedQuery = [];
    for (var cart in carts) {
      for (var item in cart.items) {
        if (item.title!.toLowerCase().contains(query.toLowerCase())) {
          matchedQuery.add(item);
        }
      }
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: ColorsManger.backGround),
      child: ListView.builder(
          itemCount: matchedQuery.length,
          itemBuilder: (context, index) {
            var result = matchedQuery[index];
            return ListTile(
              title: Text(
                result.title ?? '',
                style: AppTextStyles.normal(),
              ),
              subtitle: Text('Price : ${result.price}'),
              trailing: Image.network(result.thumbnail ?? ""),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewProducts(
                      product: result,
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Products> matchedQuery = [];
    for (var cart in carts) {
      for (var item in cart.items) {
        if (item.title!.toLowerCase().contains(
              query.toLowerCase(),
            )) {
          matchedQuery.add(item);
        }
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: matchedQuery.length,
      itemBuilder: (context, index) {
        print('###########${matchedQuery.length}');
        var result = matchedQuery[index];
        var cartId = carts.map((e) => e.cartId);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            //   child: Text(
            //     "Cart : ${carts[index].cartId}",
            //     style:
            //         AppTextStyles.semiBold(fontSize: 18, color: Colors.brown),
            //   ),
            // ),

            Card(
              child: ListTile(
                title: Text(
                  matchedQuery[index].title ?? '',
                  style: AppTextStyles.normal(fontSize: 17),
                ),
                trailing: Image.network(matchedQuery[index].thumbnail ?? ""),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewProducts(
                        product: matchedQuery[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
