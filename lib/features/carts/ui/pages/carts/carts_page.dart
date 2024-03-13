import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_cart/core/helper/spacing.dart';
import 'package:product_cart/features/carts/ui/pages/carts/widgets/cart_widget.dart';

class CartsViewPage extends StatefulWidget {
  const CartsViewPage({super.key});

  @override
  State<CartsViewPage> createState() => _CartsViewPageState();
}

class _CartsViewPageState extends State<CartsViewPage> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  cursorHeight: 30,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
              ),
              verticalSpace(20),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return CartWidgetBody();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return verticalSpace(20);
                  },
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
