import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/router/app_router.dart';
import '../../../domain/entities/event_entity.dart';
import 'check_boxes_card.dart';
import 'wave_card.dart';

class EventCardBody extends StatelessWidget {
  final EventEntity event;
  final bool isArabic;

  EventCardBody({required this.event, required this.isArabic});
  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat.Hm().format(dateTime);
    return formattedTime;
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    String? waveColor = event.dressCode;
    Color? color;
    if (waveColor != null) {
      var colorString = waveColor.replaceAll("Color(", "").replaceAll(")", "");

      if (colorString.startsWith('0x')) {
        // Remove '0x' to get the hexadecimal color string
        String hexColor = colorString.substring(2);

        // Parse the hexadecimal color string to a Color object
        color = Color(int.parse(hexColor, radix: 16));
      }
    }
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10.0),
            margin: EdgeInsets.only(
              right: isArabic ? 0 : 5,
              left: isArabic ? 5 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  formatTime(event.startsAt!),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'To',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  formatTime(event.endsAt!),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    bottom: 0,
                    child: WaveCard(
                      context: context,
                      backgroundColor: color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              event.title?.toUpperCase() ?? 'No title',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CheckBoxesCard(
                            food: event.food,
                            adultsOnly: event.adultsOnly,
                            alcohol: event.alcohol,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).disabledColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  formatDate(event.startingDate!),
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  formatDate(event.endingDate!),
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).disabledColor,
                                ),
                                onPressed: () {
                                  context.router.push(const InvitationRoute());
                                },
                                child: const Text(
                                  'Invitations',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).disabledColor,
                                ),
                                onPressed: () {
                                  context.router
                                      .push(FilterHostsRoute(event: event));
                                },
                                child: const Text(
                                  'Host',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
