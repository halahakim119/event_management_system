import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/strings/strings.dart';
import '../../../domain/entities/event_entity.dart';
import '../../logic/cubit/event_cubit.dart';
import 'event_card_body.dart';
import 'event_card_footer.dart';
import 'event_card_header.dart';
import 'host_card_event.dart';

class EventCard extends StatelessWidget {
  final EventStatus currentEventStatus;
  final EventEntity event;
  final bool isArabic;

  const EventCard({
    Key? key,
    required this.currentEventStatus,
    required this.event,
    required this.isArabic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EventCardHeader(
            isArabic: isArabic,
            event: event,
            eventCubit: context.read<EventCubit>(),
            currentEventStatus: currentEventStatus),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.only(
              topRight: currentEventStatus == EventStatus.Accepted
                  ? const Radius.circular(15)
                  : !isArabic
                      ? Radius.zero
                      : const Radius.circular(15),
              topLeft: currentEventStatus == EventStatus.Accepted
                  ? const Radius.circular(15)
                  : isArabic
                      ? Radius.zero
                      : const Radius.circular(15),
              bottomLeft: const Radius.circular(15),
              bottomRight: const Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                EventCardBody(
                    event: event,
                    isArabic: isArabic,
                    currentEventStatus: currentEventStatus),
                event.host != null || event.hostRejected != null
                    ? HostCardEvent(
                        host: event.host ?? event.hostRejected!.host!,
                        isArabic: isArabic,
                        message: event.hostRejected?.message,
                        currentEventStatus: currentEventStatus,
                      )
                    : const SizedBox(),
                EventCardFooter(event: event, isArabic: isArabic),
            
              ],
            ),
          ),
        ),
      ],
    );
  }
}
