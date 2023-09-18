import 'package:flutter/material.dart';

import '../../../domain/entities/event_entity.dart';

class EventCardHeader extends StatelessWidget {
  const EventCardHeader({
    super.key,
    required this.isArabic,
    required this.event,
  });

  final bool isArabic;
  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 15, right: isArabic ? 35 : 15, left: isArabic ? 15 : 35),
          child: Text(
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              event.type == null ? "" : event.type!.toUpperCase()),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          // padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Theme.of(context).colorScheme.error,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
