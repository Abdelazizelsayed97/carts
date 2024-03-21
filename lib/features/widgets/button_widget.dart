import 'package:flutter/material.dart';

class AddRemoveButton extends StatefulWidget {
  final Function(bool) onPressed;
  final bool isAdded = false;

  AddRemoveButton({super.key, required this.onPressed, });

  @override
  _AddRemoveButtonState createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  late bool _isAdded ;

  @override
  void initState() {
    super.initState();
    _isAdded = widget.isAdded;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isAdded = !_isAdded;
          widget.onPressed(_isAdded);

        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isAdded ? Colors.red : Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        _isAdded ? 'Remove from Cart' : 'Add to Cart',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}