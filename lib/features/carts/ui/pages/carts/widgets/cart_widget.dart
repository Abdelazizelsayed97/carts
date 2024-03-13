import 'package:flutter/material.dart';
import 'package:product_cart/core/helper/spacing.dart';

class CartWidgetBody extends StatefulWidget {
  const CartWidgetBody({super.key});

  @override
  State<CartWidgetBody> createState() => _CartWidgetBodyState();
}

class _CartWidgetBodyState extends State<CartWidgetBody> {
  final OverlayPortalController _controller = OverlayPortalController();

  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: ExpansionTile(
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(19),
            ),
          ),
          collapsedShape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(19))),
          collapsedBackgroundColor: Colors.grey,
          backgroundColor: Colors.grey.shade300,
          title: const Text("Cart 1"),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .5,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Align(
                          alignment: Alignment.topLeft,
                          child: Image.network(
                              scale: 80,
                              fit: BoxFit.cover,
                              "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=5070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        ),
                        trailing: TextButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: Text("Add",
                                style: TextStyle(color: Colors.green))),
                        subtitle: Text("ay 7age fel blala"));
                  },
                  separatorBuilder: (context, index) {
                    return verticalSpace(20);
                  },
                  itemCount: 5),
            ),
          ],
        ));
  }
}
