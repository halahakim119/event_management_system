import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/app_router.dart';
import '../../../data/models/user_profile_model.dart';
import '../../logic/bloc/user_bloc.dart';
import '../widgets/not_logged_in.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Create a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Create controllers for text fields
  bool isEditPhoneNumber = false;
  final phoneNumberController = TextEditingController();

 @override
void dispose() {
  userBox.listenable().removeListener(_onBoxChange);
  super.dispose();
}

void _onBoxChange() {
  if (mounted) {
    setState(() {
      getUserData();
    });
  }
}


  UserProfileModel? user;
  final userBox = Hive.box<UserProfileModel>('userBox');

  @override
  void initState() {
    super.initState();
    getUserData();
    userBox.listenable().addListener(_onBoxChange);
    if (userBox.isNotEmpty) {
      phoneNumberController.text = user!.phoneNumber;
    }
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  void cancelPhoneNumberEditing() {
    setState(() {
      isEditPhoneNumber = false;
      phoneNumberController.text =
          user!.phoneNumber; // Reset the name value to the original value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: userBox.isEmpty
            ? const NotLoggedIn()
            : BlocProvider(
                create: (_) => sl<UserBloc>(),
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserError) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Fail'),
                            content: Text(state.message),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is PhoneNumberVerified) {
                      log(state.verificationCode);
                      context.router.push(VeificationRoute(
                          verificationCode: state.verificationCode,
                          code: state.code,
                          typeForm: 'editPhoneNumer'));
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                        child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).cardColor,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  context.router
                                      .push(EditNameProvinceRoute(user: user!));
                                },
                                dense: true,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user!.name),
                                    const SizedBox(height: 10),
                                    Text(user!.province),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    context.router.push(
                                        EditNameProvinceRoute(user: user!));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        isEditPhoneNumber == false
                            ? Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      isEditPhoneNumber = true;
                                    });
                                  },
                                  dense: true,
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(user!.phoneNumber),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      setState(() {
                                        isEditPhoneNumber = true;
                                      });
                                    },
                                  ),
                                ),
                              )
                            : ListTile(
                                leading: IconButton(
                                  onPressed: cancelPhoneNumberEditing,
                                  icon: const Icon(Icons.cancel_outlined),
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                title: TextField(
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 0.5,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    final newPhoneNumber =
                                        phoneNumberController.text;
                                    final userId = user!.id;
                                    final token = user!.token;

                                    final verifyPhoneNumberEvent =
                                        VerifyPhoneNumberEvent(
                                            userId, newPhoneNumber, token);
                                    context
                                        .read<UserBloc>()
                                        .add(verifyPhoneNumberEvent);
                                    setState(() {
                                      isEditPhoneNumber = false;
                                    });
                                  },
                                  icon: const Icon(Icons.check),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                      ]),
                    ));
                  },
                ),
              ));
  }
}
