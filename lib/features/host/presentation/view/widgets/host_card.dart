import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../event/domain/entities/event_entity.dart';
import '../../../domain/entities/host_entity.dart';

class HostCard extends StatelessWidget {
  final List<HostEntity> hostsData;
  EventEntity event;
  HostCard({
    Key? key,
    required this.hostsData,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: hostsData.length,
      itemBuilder: (context, index) {
        final host = hostsData[index];

        return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          width: 0.5, color: Theme.of(context).dividerColor),
                      color: Theme.of(context).colorScheme.onPrimary),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Text(
                          textAlign: TextAlign.center,
                          host.name ?? '', // Display host name
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Category: ${host.category ?? ''}', // Display host category
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            onPressed: () {
                              event.host = host;
                              context.router
                                  .push(ServicesFormRoute(event: event));
                           
                            },
                            child: const Text('Request')),
                      )
                    ],
                  ))
            ]);
      },
    );
  }
}
