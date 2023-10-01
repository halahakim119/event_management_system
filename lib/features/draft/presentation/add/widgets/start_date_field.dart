import 'package:flutter/material.dart';

class StartDateField extends StatelessWidget {
  const StartDateField({
    super.key,
    required TextEditingController startingDateController,
  }) : _startingDateController = startingDateController;

  final TextEditingController _startingDateController;

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
        controller: _startingDateController,
        decoration: const InputDecoration(labelText: 'Starting Date'),
      ),
    );
  }
}
