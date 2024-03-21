import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:product_cart/core/di/app_di.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/widgets/cart_widget.dart';
import 'package:product_cart/features/carts/ui/pages/carts/product_cart/cart_button.dart';

import '../../../../../search/ui/search_page.dart';
import '../../../../domain/get_all_carts/entities/get_all_carts_enitity.dart';

class CartsViewPage extends StatelessWidget {
  const CartsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => CartsCubit(getIt()),
      child: const CartsViewBody(),
    );
  }
}

class CartsViewBody extends StatefulWidget {
  const CartsViewBody({super.key});

  @override
  State<CartsViewBody> createState() => _CartsViewBodyState();
}

class _CartsViewBodyState extends State<CartsViewBody> {
  int currentPage = 1;
  List<Carts> items = [];
  final _scrollController = ScrollController();
  List cartProduct = [];

  final PagingController<int, Carts> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 10);

  void onDataLoaded(CartsSuccessState state) async {
    context.read<CartsCubit>().loadMoreCarts(limit: 10);
    items.addAll(state.getPostState.dataItems);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      context.read<CartsCubit>().fetchData(20).whenComplete(() {
        _scrollController.addListener(() {
          if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels) {
            // final Future<List<Carts>?> newList =
            context.read<CartsCubit>().loadMoreCarts(limit: 10);
            // items.addAll(newList);
          }
          // loadMoreData();
        });
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('i passed build widget');

    return Scaffold(
      floatingActionButton: CartPreviewFloatingActionButton(),
      backgroundColor: Colors.orange.shade50,
      body: BlocConsumer<CartsCubit, CartsState>(
        listener: (context, state) {
          if (state is CartsLoadingState) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        builder: (BuildContext context, CartsState state) {
          if (state is CartsFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is CartsSuccessState) {
            items.addAll(state.getPostState.dataItems);
            return RefreshIndicator(
              // edgeOffset: 100,
              onRefresh: () async {
                onDataLoaded(state);
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
