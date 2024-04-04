import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_cart/features/search/ui/widgets/search_widget.dart';

import '../../carts/domain/get_all_carts/entities/get_all_carts_entity.dart';

class SearchPage extends StatefulWidget {
  final List<Carts> carts;

  const SearchPage({super.key, required this.carts});

  @override
  State<SearchPage> createState() => _SearchPageState(carts: carts);
}

class _SearchPageState extends State<SearchPage> {
  final List<Carts> carts;
  List<Carts> searchList = [];

  @override
  initState() {
    searchList = carts;
    super.initState();
  }

  _SearchPageState({required this.carts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
          child: TextFormField(
            onTap: () {
              showSearch(
                  context: context, delegate: CartProductSearchDelegate(carts));
            },
            cursorHeight: 30,
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(CupertinoIcons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
          ),
        ),
      ],
    );
  }
}
