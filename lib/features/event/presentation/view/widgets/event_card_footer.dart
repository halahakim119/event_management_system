import 'package:flutter/material.dart';

import '../../../domain/entities/event_entity.dart';

class EventCardFooter extends StatelessWidget {
  final EventEntity event;

  final bool isArabic;

  const EventCardFooter({
    Key? key,
    required this.event,
    required this.isArabic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "POST : ${event.postType == null ? "" : event.postType!.toUpperCase()}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "SEAT NO. : ${event.guestsNumber == null ? "" : event.guestsNumber.toString()}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: [
                isArabic
                    ? TextSpan(
                        text: event.description ?? "",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      )
                    : TextSpan(
                        text: 'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                const TextSpan(text: "  "),
                !isArabic
                    ? TextSpan(
                        text: event.description ?? "",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      )
                    : TextSpan(
                        text: 'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
