import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_cart/core/app_colors/app_colors.dart';
import 'package:product_cart/core/text_styles/app_text_styles.dart';
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

    // final List<Carts> filteredCarts = carts.where((cart) {
    //   return cart.items.any(
    //         (item) => item.title!.toLowerCase().startsWith(query.toLowerCase()),
    //   );
    // }).toList();
    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: filteredCarts.length,
    //   itemBuilder: (context, index) {
    //     return ListView.builder(
    //       physics: const NeverScrollableScrollPhysics(),
    //       shrinkWrap: true,
    //       itemCount: filteredCarts[index].items.length,
    //       itemBuilder: (context, itemIndex) {
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 horizontalSpace(15),
    //                 Text(
    //                   'Cart num: ${filteredCarts[index].cartId}',
    //                   style: AppTextStyles.bold(fontSize: 18),
    //                 ),
    //               ],
    //             ),
    //             Card(
    //               child: ListTile(
    //                 title:
    //                     Text(filteredCarts[index].items[itemIndex].title ?? ''),
    //                 // subtitle: Text(
    //                 //     'price: ${filteredCarts[index].items[itemIndex].price.toString()}'),
    //                 // trailing: Image.network(filteredCarts[index]
    //                 //     .items[itemIndex]
    //                 //     .thumbnail
    //                 //     .toString()),
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                       builder: (context) => PreviewProducts(
    //                         product: filteredCarts[index].items[itemIndex],
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Products> matchedQuery = [];
    for (var cart in carts) {
      for (var item in cart.items) {
        if (item.title!.toLowerCase().contains(query.toLowerCase())) {
          matchedQuery.add(item);
        }
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: matchedQuery.length, // Use matchedQuery.length here
      itemBuilder: (context, index) {
        var result = matchedQuery[index];
        var cartId = carts[index].cartId;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Text(
                "Cart : $cartId",
                // Use result.cartId.toString() instead of carts[index].cartId.toString()
                style:
                    AppTextStyles.semiBold(fontSize: 18, color: Colors.brown),
              ),
            ),
            ListTile(
              title: Text(
                result.title ?? '',
                style: AppTextStyles.normal(fontSize: 17),
              ),
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
            ),
          ],
        );
      },
    );
  }
}
