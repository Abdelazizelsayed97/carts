import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List<Carts> items = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      context.read<CartsCubit>().fetchData(20).whenComplete(() {
        _scrollController.addListener(() {
          if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels) {
            context.read<CartsCubit>().loadMoreCarts(limit: 10);
          }
        });
      });
    });
    print('this is init state');
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
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.orange.shade50,
      body: BlocConsumer<CartsCubit, CartsState>(
        listener: (context, state) {
          if (state is CartsLoadingState) {
            Future.delayed(const Duration(seconds: 3));
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartsFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Something Happened while loading Data')));
          }
        },
        builder: (BuildContext context, CartsState state) {
          if (state is CartsSuccessState) {
            items.addAll(state.getPostState.dataItems);
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
                            return SizedBox(
                              width: 30.w,
                              height: 30.h,
                              child: const Center(
                                heightFactor: 30,
                                widthFactor: 30,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black38),
                                ),
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
