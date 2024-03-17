import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:product_cart/core/di/app_di.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/ui/pages/carts/carts_cubit.dart';
import 'package:product_cart/features/carts/ui/pages/carts/widgets/cart_widget.dart';

import '../../../../search/ui/pages/search_page.dart';
import '../../../domain/get_all_carts/entities/get_all_carts_enitity.dart';

class CratsViewPage extends StatelessWidget {
  const CratsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartsCubit(getIt())..getAllCarts(1),
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

  final PagingController<int, Carts> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 2);
  bool _isSelected = false;

  void onDataLoaded(CartsSuccessState state) async {
    // final url = Uri.parse('https://dummyjson.com/carts?limit=5&skip=0');
    // final response  = await http.get(url);
    // if (response.statusCode == 200) {
    //   final List newItems = jsonDecode(response.body);
    // }
    // items.addAll(state.getPostState.dataItems);
    try {
      if (state.getPostState.limit == 20) {
        _pagingController.appendLastPage(state.getPostState.dataItems);
      } else {
        final nextPageKey = currentPage + 1;
        _pagingController.appendPage(state.getPostState.dataItems, nextPageKey);
      }
    } catch (e) {
      _pagingController.error(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagingController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((nextPageKey) {
      BlocProvider.of<CartsCubit>(context).getAllCarts(nextPageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: RefreshIndicator(
        edgeOffset: 100,
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: BlocBuilder<CartsCubit, CartsState>(
              builder: (context, state) {
                if (state is CartsFailureState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is CartsSuccessState) {
                  print(
                      '################################${state.getPostState.dataItems}');
                  onDataLoaded(state);
                  return Column(
                    children: [
                      verticalSpace(70),
                      SearchPage(
                        carts: state.getPostState.dataItems.toList(),
                      ),
                      PagedListView<int, Carts>.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        builderDelegate: PagedChildBuilderDelegate(
                          newPageErrorIndicatorBuilder: (context) {
                            return const SizedBox.shrink();
                          },
                          newPageProgressIndicatorBuilder: (context) {
                            Future.delayed(const Duration(seconds: 3));
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          },
                          itemBuilder: (context, item, index) {
                            return CartWidgetBody(
                              carts: state.getPostState.dataItems,
                              text: item.cartId.toString()
                              // state.getPostState.dataItems[index].cartId
                              //     .toString()
                              ,
                              indexed: index,
                            );
                          },
                        ),
                        separatorBuilder: (BuildContext context, int index) {
                          return verticalSpace(20);
                        },
                        // itemCount: state.getPostState.dataItems.length,
                        pagingController: _pagingController,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
