import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/modules/dependency_injection.dart';
import '../../../../core/router/app_router.dart';
import '../../application/draft_list_bloc/draft_list_bloc.dart';
import 'widgets/draft_list_widget.dart';

@RoutePage()
class DraftListScreen extends StatelessWidget {
  const DraftListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<DraftListBloc>()..add(const DraftListWatchRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Draft List'),
        ),
        body: const DraftListWidget(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.router.push(const AddDraftRoute());
          },
          label: const Text('DRAFT'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
