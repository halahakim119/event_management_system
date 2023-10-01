import 'package:flutter/material.dart';

class GuestNumberField extends StatelessWidget {
  const GuestNumberField({
    super.key,
    required TextEditingController seatNumberController,
  }) : _seatNumberController = seatNumberController;

  final TextEditingController _seatNumberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Seat Number'),
      controller: _seatNumberController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seat number cannot be empty';
        }
        if (int.tryParse(value) == null) {
          return 'Seat number must be a valid integer';
        }

        return null;
      },
    );
  }
}
