// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:event_management_system/features/host/domain/entities/host_entity.dart';
import 'package:event_management_system/features/host/presentation/logic/cubit/hosts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../widgets/host_filter.dart';

@RoutePage()
class FilterHostsScreen extends StatefulWidget {
  @override
  _FilterHostsScreenState createState() => _FilterHostsScreenState();
}

class _FilterHostsScreenState extends State<FilterHostsScreen> {
  List<HostEntity>? hostsData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) =>
            sl<HostsCubit>()..filterHosts(filterHostEntity: null),
        child: BlocConsumer<HostsCubit, HostsState>(
          listener: (context, state) {
            state.when(
              initial: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (hosts) {
                hostsData = hosts;
              },
              error: (message) {},
            );
          },
          builder: (context, state) {
            return SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const HostFilter(),
                    state.when(
                      initial: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: (hosts) {
                        hostsData = hosts;
                        return HostCard(
                          hostsData: hostsData!,
                        );
                      },
                      error: (message) => Center(child: Text(message)),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}

class HostCard extends StatelessWidget {
  final List<HostEntity> hostsData;

  HostCard({
    Key? key,
    required this.hostsData,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              'Category: ${host.category ?? ''}', // Display host category
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'services: ${host.services ?? ''}', // Display host province
                            ),
                            SizedBox(height: 8),
                            Text(
                              'services: ${host.serviceDescription ?? ''}', // Display host province
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text('Request')),
                      )
                    ],
                  ))
            ]);
      },
    );
  }
}
