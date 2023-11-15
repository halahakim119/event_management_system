// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_management_system/core/injection/injection_imports.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../../core/strings/strings.dart';
import '../../../../user/domain/entities/user_entity.dart';
import '../../../domain/entities/event_entity.dart';
import 'event_card.dart';

class MyEventsWidget extends StatefulWidget {
  MyEventsWidget({
    Key? key,
    required this.user,
    required this.isArabic,
  }) : super(key: key);
  final UserEntity user;
  final bool isArabic;

  @override
  State<MyEventsWidget> createState() => _MyEventsWidgetState();
}

class _MyEventsWidgetState extends State<MyEventsWidget> {
  EventStatus? currentEventStatus;
  List<EventEntity> filteredEvents = [];

  @override
  void initState() {
    super.initState();
    // Filter the events initially based on the current status
    filterEventsByStatus();
  }

  // Function to filter events based on the current status
  void filterEventsByStatus() {
    setState(() {
      if (currentEventStatus != null) {
        // If status is not null, filter events based on the status
        filteredEvents = widget.user.events!
            .where((event) =>
                getStatusFromString(event.eventStatus!) == currentEventStatus)
            .toList();
      } else {
        // If status is pending, eventEditByHost, canceledByHost, or Denied,
        // show events with any of these statuses
        filteredEvents = widget.user.events!
            .where((event) => [
                  EventStatus.pending,
                  EventStatus.eventEditByHost,
                  EventStatus.canceledByHost,
                  EventStatus.Denied,
                ].contains(getStatusFromString(event.eventStatus!)))
            .toList();
      }
    });
  }

  EventStatus getStatusFromString(String status) {
    switch (status) {
      case "pending":
        return EventStatus.pending;
      case "Denied":
        return EventStatus.Denied;
      case "eventEditByHost":
        return EventStatus.eventEditByHost;
      case "canceledByHost":
        return EventStatus.canceledByHost;
      case "Accepted":
        return EventStatus.Accepted;
      default:
        return EventStatus.pending; // Default to pending if status is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GNav(
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            tabActiveBorder:
                Border.all(color: Colors.black, width: 1), // tab button border
            tabBorder:
                Border.all(color: Colors.grey, width: 1), // tab button border
            curve: Curves.easeOutExpo, // tab animation curves
            duration:
                const Duration(milliseconds: 300), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: Colors.purple, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: const Color.fromRGBO(156, 39, 176, 1)
                .withOpacity(0.1), // selected tab background color
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 10), // navigation bar padding
            tabs: [
              GButton(
                onPressed: () {
                  setState(() {
                    currentEventStatus = null;
                    filterEventsByStatus();
                  });
                },
                icon: Icons.event_repeat_rounded,
                text: 'PENDING',
              ),
              GButton(
                onPressed: () {
                  setState(() {
                    currentEventStatus = EventStatus.Accepted;
                    filterEventsByStatus();
                  });
                },
                icon: Icons.event_available_rounded,
                text: 'EVENTS',
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 0.3,
                endIndent: 15,
                indent: 15,
              );
            },
            itemCount: filteredEvents.length,
            itemBuilder: (context, index) {
              EventEntity event = filteredEvents.reversed.toList()[index];
              return EventCard(
                  event: event,
                  isArabic: widget.isArabic,
                  currentEventStatus: getStatusFromString(event.eventStatus!));
            },
          ),
        )
      ],
    );
  }
}
