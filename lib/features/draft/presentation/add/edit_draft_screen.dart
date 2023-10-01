import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/draft/draft.dart';
import 'widgets/create_edit_draft_form_widget.dart';

@RoutePage()
class EditDraftScreen extends StatelessWidget {
  Draft draft;

  EditDraftScreen({
    Key? key,
    required this.draft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Draft'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: CreateEditDraftFormWidget(
            draft: draft,
            isEdit: true,
          ),
        ),
      ),
    );
  }
}
