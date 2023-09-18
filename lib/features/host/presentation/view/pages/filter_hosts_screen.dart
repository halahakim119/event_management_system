import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../event/domain/entities/event_entity.dart';
import '../../../../event/presentation/logic/cubit/request_cubit.dart';
import '../../../domain/entities/host_entity.dart';
import '../../logic/cubit/hosts_cubit.dart';
import '../widgets/host_card.dart';
import '../widgets/host_filter.dart';

@RoutePage()
class FilterHostsScreen extends StatefulWidget {
  EventEntity event;
  FilterHostsScreen({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _FilterHostsScreenState createState() => _FilterHostsScreenState();
}

class _FilterHostsScreenState extends State<FilterHostsScreen> {
  List<HostEntity>? hostsData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<HostsCubit>()..filterHosts(filterHostEntity: null),
          ),
          BlocProvider(
            create: (context) => sl<RequestCubit>(),
          ),
        ],
        child: BlocConsumer<RequestCubit, RequestState>(
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
                            Navigator.of(context).pop();
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
            return BlocConsumer<HostsCubit, HostsState>(
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
                                hostsData: hostsData!, event: widget.event);
                          },
                          error: (message) => Center(child: Text(message)),
                        )
                      ],
                    ));
              },
            );
          },
        ),
      ),
    );
  }
}
