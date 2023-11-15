import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/injection/injection_imports.dart';
import '../../../domain/entities/event_entity.dart';

class EventCardHeader extends StatelessWidget {
  const EventCardHeader({
    Key? key,
    this.currentEventStatus,
    required this.isArabic,
    required this.event,
    required this.eventCubit,
  }) : super(key: key);
  final EventStatus? currentEventStatus;
  final bool isArabic;
  final EventEntity event;
  final EventCubit eventCubit;

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
        currentEventStatus == EventStatus.pending ||
                currentEventStatus == EventStatus.Denied ||
                currentEventStatus == EventStatus.canceledByHost ||
                currentEventStatus == EventStatus.eventEditByHost
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Text(
                      currentEventStatus!.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    // padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      title: const Text(
                                          textAlign: TextAlign.center,
                                          'Are you sure you want to delete event?'),
                                      content: const Text(
                                          'delete will remove all data entered'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                        BlocProvider(
                                          create: (context) => sl<EventCubit>(),
                                          child: BlocBuilder<EventCubit,
                                              EventState>(
                                            builder: (context, state) {
                                              return TextButton(
                                                onPressed: () {
                                                  eventCubit.delete(
                                                      id: event.id!);
                                                  context.router.pop();
                                                },
                                                child: const Text('Yes'),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              color: Theme.of(context).colorScheme.error,
                            )),
                        currentEventStatus == EventStatus.eventEditByHost
                            ? IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          title: const Text(
                                              textAlign: TextAlign.center,
                                              'Are you sure you want to accept ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('No'),
                                            ),
                                            BlocProvider(
                                              create: (context) =>
                                                  sl<EventCubit>(),
                                              child: BlocConsumer<EventCubit,
                                                  EventState>(
                                                listener: (context, state) {
                                                  state.maybeWhen(
                                                    created: (message) {
                                                      // Event created successfully, initiate the delete operation
                                                      context
                                                          .read<EventCubit>()
                                                          .delete(
                                                              id: event.id!);
                                                    },
                                                    error: (errorMessage) {
                                                      // Handle the error, e.g., show a snackbar or alert dialog
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              errorMessage),
                                                        ),
                                                      );
                                                    },
                                                    orElse: () {},
                                                  );
                                                },
                                                builder: (context, state) {
                                                  return TextButton(
                                                    onPressed: () {
                                                      // Initiate the event creation process
                                                      context
                                                          .read<EventCubit>()
                                                          .create(event: event);
                                                    },
                                                    child: const Text('Yes'),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Theme.of(context).colorScheme.primary,
                                ))
                            : const SizedBox()
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
