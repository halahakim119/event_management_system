import 'package:flutter/material.dart';

class EndDateField extends StatelessWidget {
  const EndDateField({
    super.key,
    required TextEditingController endingDateController,
  }) : _endingDateController = endingDateController;

  final TextEditingController _endingDateController;

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
        controller: _endingDateController,
        decoration: const InputDecoration(labelText: 'Ending Date'),
      ),
    );
  }
}
