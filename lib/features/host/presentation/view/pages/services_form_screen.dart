import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:event_management_system/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../event/domain/entities/event_entity.dart';
import '../../../../event/presentation/logic/cubit/event_cubit.dart';

@RoutePage()
class ServicesFormScreen extends StatefulWidget {
  final EventEntity event;

  ServicesFormScreen({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _ServicesFormScreenState createState() => _ServicesFormScreenState();
}

class _ServicesFormScreenState extends State<ServicesFormScreen> {
  Map<String, int> selectedServices = {};
  Map<String, double> servicePrices = {};

  @override
  void initState() {
    super.initState();

    // Populate servicePrices from widget.event.host!.services!
    if (widget.event.host != null && widget.event.host!.services != null) {
      for (var service in widget.event.host!.services!) {
        if (service.title != null && service.price != null) {
          servicePrices[service.title!] = service.price!.toDouble();
        }
      }
    }
  }

  double calculateTotalPrice() {
    double total = 0.0;
    selectedServices.forEach((serviceName, quantity) {
      total += (servicePrices[serviceName] ?? 0.0) * quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EventCubit>(),
      child: BlocConsumer<EventCubit, EventState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            created: (message) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('request sent'),
                    content: Text(message),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          context.router.popUntil(
                              (route) => route.settings.name == MainRoute.name);
                          context.router.push(const MyEventsRoute());
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            error: (message) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('failed to request'),
                    content: Text(message),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        builder: (context, state) {
          state.maybeWhen(
            orElse: () {},
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            created: (message) => Center(child: Text(message)),
            error: (message) => Center(child: Text(message)),
          );
          return Scaffold(
            appBar: AppBar(title: Text('Select Services')),
            body: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: servicePrices.length,
              itemBuilder: (context, index) {
                final serviceName = servicePrices.keys.elementAt(index);
                final servicePrice = servicePrices[serviceName] ?? 0.0;
                final isSelected = selectedServices.containsKey(serviceName);

                return ListTile(
                  title: Text(serviceName),
                  subtitle: Text('\$$servicePrice'),
                  trailing: isSelected
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (selectedServices[serviceName]! > 1) {
                                    setState(() {
                                      selectedServices[serviceName] =
                                          selectedServices[serviceName]! - 1;
                                    });
                                  } else {
                                    setState(() {
                                      selectedServices.remove(serviceName);
                                    });
                                  }
                                });
                              },
                            ),
                            Text(selectedServices[serviceName].toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  selectedServices[serviceName] =
                                      (selectedServices[serviceName] ?? 0) + 1;
                                });
                              },
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedServices[serviceName] = 1;
                            });
                          },
                          child: Text('Add'),
                        ),
                );
              },
            ),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}'),
                    ElevatedButton(
                      onPressed: () {
                        log(widget.event.toString());
                        context.read<EventCubit>()..create(event: widget.event);
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
