import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:product_cart/core/di/app_di.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/ui/pages/carts/carts_cubit.dart';
import 'package:product_cart/features/carts/ui/pages/carts/widgets/cart_widget.dart';

import '../../../../search/ui/search_page.dart';
import '../../../domain/get_all_carts/entities/get_all_carts_enitity.dart';

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
  List items = [];
  int totalProducts = 10000;
  final scrollController = ScrollController();

  final PagingController<int, Carts> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 10);
  void loadMoreData() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent &&
        items.length < totalProducts) {
      context.read<CartsCubit>().fetchData(10);
    }
  }
  bool _isSelected = false;

  void onDataLoaded(CartsSuccessState state) async {
    context
        .read<CartsCubit>()
        .loadMoreCarts(limit: _pagingController.invisibleItemsThreshold ?? 5);
    items.addAll(state.getPostState.dataItems);
    try {
      if (state.getPostState.limit == 20) {
        _pagingController.appendLastPage(state.getPostState.dataItems);
      } else {
        final nextPageKey = state.getPostState.limit! + 5;
        _pagingController.appendPage(state.getPostState.dataItems, nextPageKey);
      }
    } catch (e) {
      _pagingController.error(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addListener(() {
      context
          .read<CartsCubit>()
          .fetchData(_pagingController.invisibleItemsThreshold ?? 10);
    });
    context
        .read<CartsCubit>()
        .fetchData(_pagingController.invisibleItemsThreshold ?? 5);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('i passed build widget');

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: BlocBuilder<CartsCubit, CartsState>(
        builder: (BuildContext context, CartsState state) {
          if (state is CartsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartsFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is CartsSuccessState) {
            items.addAll(state.getPostState.dataItems);
            return RefreshIndicator(
              edgeOffset: 100,
              onRefresh: () async {
                _pagingController.refresh();
                onDataLoaded(state);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    children: [
                      verticalSpace(70),
                      SearchPage(
                        carts: state.getPostState.dataItems.toList(),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.getPostState.dataItems.length,

                          itemBuilder: (context, index) {
                            return CartWidgetBody(
                              carts: state.getPostState.dataItems,
                              text: state.getPostState.dataItems[index].cartId. toString(),
                              indexed: index,
                            );
                          },
                          separatorBuilder:(context, index) => verticalSpace(20),
                          ),
                      // PagedListView<int, Carts>.separated(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   builderDelegate: PagedChildBuilderDelegate<Carts>(
                      //     animateTransitions: true,
                      //     newPageErrorIndicatorBuilder: (context) {
                      //       return const SizedBox.shrink();
                      //     },
                      //     newPageProgressIndicatorBuilder: (context) {
                      //       Future.delayed(const Duration(seconds: 3));
                      //       return const Center(
                      //         child: CircularProgressIndicator(
                      //           color: Colors.red,
                      //         ),
                      //       );
                      //     },
                      //     itemBuilder: (context, item, index) {
                      //       return CartWidgetBody(
                      //         carts: state.getPostState.dataItems,
                      //         text: item.cartId.toString(),
                      //         indexed: index,
                      //       );
                      //     },
                      //   ),
                      //   separatorBuilder: (BuildContext context, int index) {
                      //     return verticalSpace(20);
                      //   },
                      //   pagingController: _pagingController,
                      // ),
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
