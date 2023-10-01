import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _descriptionController,
      maxLength: 500,
      decoration: const InputDecoration(labelText: 'Event Description'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Event description cannot be empty';
        }

        return null;
      },
    );
  }
}
