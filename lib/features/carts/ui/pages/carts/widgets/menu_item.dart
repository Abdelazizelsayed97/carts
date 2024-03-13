import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    this.width,
    required this.onItemTap,
  });

  final double? width;
  final VoidCallback onItemTap;

  @override
  Widget build(BuildContext context) {
    return
     Container(
       color: Colors.transparent,
      width: width ?? 200,
      padding: const EdgeInsets.all(20),
      // decoration: ShapeDecoration(
      //   color: Theme.of(context).colorScheme.primaryContainer,
      //   shape: RoundedRectangleBorder(
      //     side: const BorderSide(
      //       width: 1.5,
      //       color: Colors.black26,
      //     ),
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      //   shadows: const [
      //     BoxShadow(
      //       color: Color(0x11000000),
      //       blurRadius: 32,
      //       offset: Offset(0, 20),
      //       spreadRadius: -8,
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: ListTile(
                   title: Row(
                     children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT73Hx3joXluMeacnnC_5P92ZM4zbZq6-VYvWGrgPwLmEWlLRepRH1jYOGoQyHJYbviEnU&usqp=CAU'),
                    ),

                  ],
                ),
              )),
              const SizedBox(width: 8),
              Expanded(
                child: _FakeItemHolder(
                  text: 'Item 2',
                  onTap: onItemTap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _FakeItemHolder extends StatelessWidget {
  const _FakeItemHolder({
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 80,
      child: Material(
        color: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
