import 'package:flutter/material.dart';

class CheckBoxesCard extends StatelessWidget {
  const CheckBoxesCard({
    super.key,
    required this.food,
    required this.adultsOnly,
    required this.alcohol,
  });

  final bool? food;
  final bool? adultsOnly;
  final bool? alcohol;

  @override
  Widget build(BuildContext context) {
    Row? foodRow = (food == false || food == null)
        ? const Row()
        : const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check,
                size: 18,
              ),
              SizedBox(width: 5),
              Text('Food'),
            ],
          );
    Row? adultsOnlyRow = (adultsOnly == false || adultsOnly == null)
        ? const Row()
        : const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check,
                size: 18,
              ),
              SizedBox(width: 5),
              Text('Children Allowd'),
            ],
          );
    Row? alcoholRow = (alcohol == false || alcohol == null)
        ? const Row()
        : const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check,
                size: 18,
              ),
              SizedBox(width: 5),
              Text('Alcohol'),
            ],
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [foodRow, adultsOnlyRow, alcoholRow],
    );
  }
}
