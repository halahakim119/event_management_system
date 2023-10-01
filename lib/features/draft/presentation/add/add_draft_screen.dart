import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'widgets/create_edit_draft_form_widget.dart';

@RoutePage()
class AddDraftScreen extends StatelessWidget {
  const AddDraftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Draft'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: CreateEditDraftFormWidget(),
        ),
      ),
    );
  }
}
