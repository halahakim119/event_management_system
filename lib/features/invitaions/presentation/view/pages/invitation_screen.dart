import 'package:auto_route/auto_route.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../logic/cubit/invitations_cubit.dart';

Future<List<Contact>> fetchContacts(BuildContext context) async {
  // Check and request contacts permission if necessary.
  bool isGranted = await Permission.contacts.status.isGranted;
  if (!isGranted) {
    isGranted = await Permission.contacts.request().isGranted;
  }
  if (isGranted) {
    return await FastContacts.getAllContacts();
  }
  return [];
}

@RoutePage()
class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Contact>>(
        future: fetchContacts(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the data is loading, show a CircularProgressIndicator.
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If an error occurred while fetching contacts, display an error message.
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            // If snapshot.data is null or empty, display a message.
            return const Center(
              child: Text("No contacts found"),
            );
          } else {
            // Extract phone numbers from contacts
            final List<String> phoneNumbers = snapshot.data!
                .map((contact) =>
                    contact.phones.isNotEmpty ? contact.phones[0].number : "")
                .where((phoneNumber) => phoneNumber.isNotEmpty)
                .toList();

            return BlocProvider(
              create: (context) =>
                  sl<InvitationsCubit>()..getUsers(phoneNumbers: phoneNumbers),
              child: BlocConsumer<InvitationsCubit, InvitationsState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (failure) {
                      // Schedule the dialog to be shown after the build process is complete.
                      Future.delayed(Duration.zero, () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Failed to create'),
                              content: Text(failure.toString()),
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
                      });
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    loaded: (users) {
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: Icon(Icons.person_2_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            title: Text(user.name),
                            subtitle: Text(user.phoneNumber),
                          );
                        },
                      );
                    },
                    error: (failure) {
                      return Center(
                        child: Text(failure),
                      );
                    },
                    orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
