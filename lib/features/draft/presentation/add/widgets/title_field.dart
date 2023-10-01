
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(labelText: 'Event Title'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Event title cannot be empty';
        }

        return null;
      },
    );
  }
}
