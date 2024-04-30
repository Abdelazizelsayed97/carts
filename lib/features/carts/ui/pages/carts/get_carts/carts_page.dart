import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/widgets/cart_widget.dart';
import 'package:product_cart/features/carts/ui/pages/carts/product_cart/cart_button.dart';

import '../../../../../search/ui/search_page.dart';
import '../../../../domain/get_all_carts/entities/get_all_carts_entity.dart';

class CartsViewPage extends StatefulWidget {
  const CartsViewPage({super.key});

  @override
  State<CartsViewPage> createState() => _CartsViewPageState();
}

class _CartsViewPageState extends State<CartsViewPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final fetch = context.read<CartsCubit>().fetchData(20);
    loadMore();
  }

  void loadMore() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        context.read<CartsCubit>().loadMoreCarts(limit: 10);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CartPreviewFloatingActionButton(
        onTap: () {
          // Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.orange.shade50,
      body: BlocConsumer<CartsCubit, CartsState>(
        listener: (context, state) {
          if (state is CartsFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('There Is no Data To show')));
          }
        },
        builder: (BuildContext context, CartsState state) {
          print('state is ${state.toString()}');
          if (state is CartsLoadingState) {
            Future.delayed(const Duration(seconds: 3));
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartsSuccessState) {
            List<Carts> items = context.read<CartsCubit>().cartData ?? [];
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CartsCubit>().loadMoreCarts(limit: 10);
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    children: [
                      verticalSpace(70),
                      SearchPage(
                        carts: items,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: items.length + 1,
                        itemBuilder: (context, index) {
                          if (index < items.length) {
                            return CartWidgetBody(
                              carts: items,
                              text: items[index].cartId.toString(),
                              indexed: index,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black38),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) => verticalSpace(20),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
