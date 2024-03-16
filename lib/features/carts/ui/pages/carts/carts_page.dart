import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:product_cart/core/di/app_di.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/ui/pages/carts/carts_cubit.dart';
import 'package:product_cart/features/carts/ui/pages/carts/widgets/cart_widget.dart';

import '../../../domain/get_all_carts/entities/get_all_carts_enitity.dart';

class CratsViewPage extends StatelessWidget {
  const CratsViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartsCubit(getIt())..getAllPosts(1),
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
  int currentPage =1 ;
  final PagingController<int, Carts> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 10);
  bool _isSelected = false;
  void onDataLoaded(CartsSuccessState state) {
    try {
      if (state.getPostState.limit == 20 ) {
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
  Widget build(BuildContext context) {
    return SafeArea(
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
                onDataLoaded(state);
                return Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                      child: TextFormField(
                        cursorHeight: 30,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                    verticalSpace(20),
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
                            text: state.getPostState.dataItems[index].cartId
                                .toString(),
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
    );
  }
}
