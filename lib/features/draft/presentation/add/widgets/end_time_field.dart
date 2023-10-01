import 'package:flutter/material.dart';

class EndTimeField extends StatelessWidget {
  const EndTimeField({
    super.key,
    required TextEditingController endsAtController,
  }) : _endsAtController = endsAtController;

  final TextEditingController _endsAtController;

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
        controller: _endsAtController,
        decoration: const InputDecoration(labelText: 'Ends At'),
      ),
    );
  }
}
