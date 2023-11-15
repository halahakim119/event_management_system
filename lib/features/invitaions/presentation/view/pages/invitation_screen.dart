// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:event_management_system/features/draft/domain/entities/draft/draft.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/injection/modules/dependency_injection.dart';
import '../../../../draft/application/draft_bloc/draft_bloc.dart';
import '../../../data/models/participant_model.dart';
import '../../../domain/entities/participant_entity.dart';
import '../../logic/cubit/invitations_cubit.dart';

@RoutePage()
class InvitationScreen extends StatefulWidget {
  Draft draft;
  bool? isEdit;
  InvitationScreen({Key? key, required this.draft, this.isEdit})
      : super(key: key);
  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  List<ParticipantModel>? guestNumbers;
  List<Contact>? contacts;
  TextEditingController searchController = TextEditingController();
  List<ParticipantEntity> filteredUsers = [];
  @override
  void initState() {
    super.initState();
// Initialize guestNumbers with participants from widget.draft.guestsNumbers
    if (widget.draft.guestsNumbers != null) {
      guestNumbers = List.from(widget.draft.guestsNumbers ?? []);
    }

    fetchContacts(context);
  }

  void addToGuestList(ParticipantModel phoneNumber) {
    setState(() {
      guestNumbers ??= []; // Initialize if null
      guestNumbers!.add(phoneNumber);
      print(guestNumbers);
    });
  }

  void removeFromGuestList(ParticipantModel phoneNumber) {
    setState(() {
      guestNumbers ??= []; // Initialize if null
      guestNumbers!.remove(phoneNumber);
      print(guestNumbers);
    });
  }

  Future<void> fetchContacts(BuildContext context) async {
    // Check and request contacts permission if necessary.
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      final contactsData = await FastContacts.getAllContacts();
      setState(() {
        contacts = contactsData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String>? phoneNumbers = contacts == null
        ? []
        : contacts!
            .map((contact) =>
                contact.phones.isNotEmpty ? contact.phones[0].number : "")
            .where((phoneNumber) => phoneNumber.isNotEmpty)
            .toList();
    guestNumbers ??= []; // Initialize if null
    return contacts == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : contacts!.isEmpty
            ? const Center(
                child: Text("No contacts found"),
              )
            : Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      BlocProvider(
                        create: (context) => sl<InvitationsCubit>()
                          ..getUsers(phoneNumbers: phoneNumbers),
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
                                // Filter the list based on the search query
                                filteredUsers = users
                                    .where((user) =>
                                        user.name!.toLowerCase().contains(
                                            searchController.text
                                                .toLowerCase()) ||
                                        user.phoneNumber!
                                            .toLowerCase()
                                            .contains(searchController.text
                                                .toLowerCase()))
                                    .toList();

                                return Column(
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05),
                                    TextField(
                                      controller: searchController,
                                      onChanged: (query) {
                                        setState(() {
                                          filteredUsers = users
                                              .where((user) =>
                                                  user.name!
                                                      .toLowerCase()
                                                      .contains(query
                                                          .toLowerCase()) ||
                                                  user.phoneNumber!
                                                      .toLowerCase()
                                                      .contains(
                                                          query.toLowerCase()))
                                              .toList();
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText:
                                            'Search by name or phone number',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      width: double.infinity,
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text("Remove All")),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text("Select All"))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        padding:
                                            const EdgeInsets.only(bottom: 50),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 5),
                                        itemCount: filteredUsers.length,
                                        itemBuilder: (context, index) {
                                          final user = filteredUsers[index];
                                          final phoneNumber = user.phoneNumber;
                                          final bool isAdded =
                                              guestNumbers?.any((participant) =>
                                                      participant.phoneNumber ==
                                                      phoneNumber) ??
                                                  false;

                                          return ListTile(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 0.5,
                                                  color: Theme.of(context)
                                                      .primaryColorLight),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              child: Icon(
                                                Icons.person_2_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                            ),
                                            title: Text(user.name ?? ''),
                                            tileColor: isAdded
                                                ? Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.03)
                                                : null,
                                            subtitle:
                                                Text(user.phoneNumber ?? ""),
                                            trailing: isAdded
                                                ? TextButton(
                                                    onPressed: () {
                                                      removeFromGuestList(
                                                          ParticipantModel(
                                                              name: user.name,
                                                              phoneNumber: user
                                                                  .phoneNumber));
                                                    },
                                                    child: const Text('DELETE'),
                                                  )
                                                : TextButton(
                                                    onPressed: () {
                                                      addToGuestList(
                                                          ParticipantModel(
                                                              name: user.name,
                                                              phoneNumber: user
                                                                  .phoneNumber));
                                                    },
                                                    child: const Text('ADD'),
                                                  ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
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
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error),
                                  onPressed: () {
                                    widget.isEdit != null ||
                                            widget.isEdit == true ||
                                            widget.isEdit.toString() == "true"
                                        ? context.router.popUntilRouteWithName(
                                            'EditDraftRoute')
                                        : showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                title: const Text(
                                                    textAlign: TextAlign.center,
                                                    'Are you sure you want to go back?'),
                                                content: const Text(
                                                    'going back will remove all selected participants'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the dialog
                                                    },
                                                    child: const Text('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context.router
                                                          .popUntilRouteWithName(
                                                              'AddDraftRoute');
                                                    },
                                                    child: const Text('Yes'),
                                                  ),
                                                ],
                                              );
                                            });
                                  },
                                  child: const Text("BACK")),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            title: const Text(
                                                textAlign: TextAlign.center,
                                                'Are you sure you want to cancel draft creation?'),
                                            content: const Text(
                                                'cancel will remove all data entered'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context); // Close the dialog
                                                },
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context.router
                                                      .popUntilRouteWithName(
                                                          'DraftListRoute');
                                                },
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text("Canel Creation")),
                              BlocProvider(
                                create: (context) => getIt.get<DraftBloc>(),
                                child: BlocConsumer<DraftBloc, DraftState>(
                                  listener: (context, state) {
                                    if (state is DraftAddedState) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  textAlign: TextAlign.center,
                                                  'Added'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    context.router
                                                        .popUntilRouteWithName(
                                                            'DraftListRoute');
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          });
                                    } else if (state is DraftEditedState) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  textAlign: TextAlign.center,
                                                  'edited '),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    context.router
                                                        .popUntilRouteWithName(
                                                            'DraftListRoute');
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          });
                                    } else if (state is DraftFailureState) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(state.error),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(context).primaryColor),
                                      onPressed: () {
                                        Draft draft = Draft(
                                            id: widget.draft.id,
                                            guestsNumbers: guestNumbers,
                                            description:
                                                widget.draft.description,
                                            dressCode: widget.draft.dressCode,
                                            endingDate: widget.draft.endingDate,
                                            adultsOnly: widget.draft.adultsOnly,
                                            alcohol: widget.draft.alcohol,
                                            endsAt: widget.draft.endsAt,
                                            food: widget.draft.food,
                                            guestsNumber:
                                                widget.draft.guestsNumber,
                                            postType: widget.draft.postType,
                                            startingDate:
                                                widget.draft.startingDate,
                                            startsAt: widget.draft.startsAt,
                                            title: widget.draft.title,
                                            type: widget.draft.type);
                                        widget.isEdit != null ||
                                                widget.isEdit == true ||
                                                widget.isEdit.toString() ==
                                                    'true'
                                            ? context.read<DraftBloc>().add(
                                                  DraftEditRequested(
                                                      draft: draft),
                                                )
                                            : context.read<DraftBloc>().add(
                                                  DraftAddRequested(
                                                      draft: draft),
                                                );
                                      },
                                      child: const Text("DONE")),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              );
  }
}
