import 'package:flutter/material.dart';

class StartTimeField extends StatelessWidget {
  const StartTimeField({
    super.key,
    required TextEditingController startsAtController,
  }) : _startsAtController = startsAtController;

  final TextEditingController _startsAtController;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: TextFormField(
        keyboardType: TextInputType.none,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'It cannot be empty';
          }
          return null;
        },
        controller: _startsAtController,
        decoration: const InputDecoration(labelText: 'Starts At'),
      ),
    );
  }
}
