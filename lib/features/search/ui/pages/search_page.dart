import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../carts/domain/get_all_carts/entities/get_all_carts_enitity.dart';

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

  void searchFilter(String entryKeyWord) {
    List<Carts> result = [];
    if (entryKeyWord.isNotEmpty) {
      for (var i = 0; i < searchList.length; i++) {
        if (searchList[i]
            .items[i]
            .title!
            .toLowerCase()
            .contains(entryKeyWord.toLowerCase())) {
          result.add(searchList[i]);
        }
      }
      setState(() {
        searchList = result;
      });
    } else {
      // setState(() {
      //   result = carts.cast<Products>().where((element) {
      //     return element['title']
      //         .toString()
      //         .toLowerCase()
      //         .contains(entryKeyWord.toLowerCase());
      //   }).toList();
      // });

      setState(() {
        result = carts;
      });
    }
    setState(() {
      searchList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
          child: TextFormField(
            onChanged: (value) => searchFilter(value),
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
