import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/draft_list_bloc/draft_list_bloc.dart';
import 'draft_tile.dart';

class DraftListWidget extends StatelessWidget {
  const DraftListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DraftListBloc, DraftListState>(
      buildWhen: (previous, current) =>
          previous.draftList.length != current.draftList.length,
      builder: (context, state) {
        if (state.draftList.isEmpty) {
          return const Center(
            child: Text('draft list is empty'),
          );
        }
        return ListView.builder(
          itemCount: state.draftList.length,
          itemBuilder: (context, index) {
            return DraftTile(
             
              draft:  state.draftList.reversed.elementAt(index),
            );
          },
        );
      },
    );
  }
}
