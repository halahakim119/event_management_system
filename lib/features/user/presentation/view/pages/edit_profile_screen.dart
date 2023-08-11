import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/strings/strings.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../data/models/user_profile_model.dart';
import '../../logic/bloc/user_bloc.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  bool isEditPhoneNumber = false;
  final phoneNumberController = TextEditingController();

  String getEnglishProvince(String arabicProvince) {
    // Map containing Arabic province names as keys and their corresponding English names as values
    Map<String, String> arabicToEnglishProvinces = {
      // Replace these values with the correct English names for the provinces
      'الأنبار': 'AlAnbar',
      'المثنى': 'AlMuthanna',
      'القادسية': 'AlQadisiyah',
      'النجف': 'AlNajaf',
      'أربيل': 'Erbil',
      'السليمانية': 'AlSulaymaniyah',
      'بابل': 'Babil',
      'بغداد': 'Baghdad',
      'البصرة': 'Basra',
      'ذي قار': 'DhiQar',
      'ديالى': 'Diyala',
      'دهوك': 'Duhok',
      'كربلاء': 'Karbala',
      'كركوك': 'Kirkuk',
      'ميسان': 'Maysan',
      'نينوى': 'Ninawa',
      'صلاح الدين': 'Saladin',
      'واسط': 'Wasit',
      'حلبجة': 'Halabja',
    };

    // Check if the given Arabic province exists in the map, and return its English value
    return arabicToEnglishProvinces[arabicProvince] ?? arabicProvince;
  }

  // Function to submit the form
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Get the selected province from the DropdownButtonFormField
      String selectedProvince = _provinceController.text.trim();

      // Convert the selected province to English if the current locale is Arabic
      if (EasyLocalization.of(context)!.locale == const Locale('ar')) {
        selectedProvince = getEnglishProvince(selectedProvince);
      }

      // Dispatch an event to the AuthenticationBloc to sign up with the provided data
      sl<UserBloc>().add(
        EditUserEvent(
          user!.id,
          user!.token,
          _nameController.text.trim(),
          selectedProvince,
        ),
      );
    }
  }

  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  void _onBoxChange() {
    setState(() {
      getUserData();
    });
  }

  UserProfileModel? user;
  final userBox = Hive.box<UserProfileModel>('userBox');

  @override
  void initState() {
    super.initState();

    getUserData();
    userBox.listenable().addListener(_onBoxChange);
    _nameController.text = user!.name;
    _provinceController.text = user!.province;
    phoneNumberController.text = user!.phoneNumber;
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
            ? Center(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'you are not logged in',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ))
            : BlocProvider(
                create: (_) => sl<UserBloc>(),
                child: BlocListener<UserBloc, UserState>(
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
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is UserEdited) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Success'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else if (state is PhoneNumberVerified) {
                      print(state.verificationCode);
                      context.router.push(VeificationRoute(
                          verificationCode: state.verificationCode,
                          code: state.code,
                          typeForm: 'editPhoneNumer'));
                    } else if (state is PhoneNumberUpdated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Success'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                          child: Form(
                        key: _formKey,
                        child: Column(children: [
                          CustomTextField(
                            max: 50,
                            labelText: LocaleKeys.Name.tr(),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                            controller: _nameController,
                          ),
                          DropdownButtonFormField<String>(
                            value: _provinceController.text,
                            borderRadius: BorderRadius.circular(25),
                            items: provinces.map((province) {
                              return DropdownMenuItem<String>(
                                value: province,
                                child: Text(province),
                              );
                            }).toList(),
                            onChanged: (selectedValue) {
                              setState(() => _provinceController.text =
                                  selectedValue ?? '');
                            },
                            decoration: InputDecoration(
                              labelText: LocaleKeys.Province.tr(),
                            ),
                          ),
                          ElevatedButton(
                            child: Text(LocaleKeys.Sign_Up.tr()),
                            onPressed: () => _submitForm(context),
                          ),
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
                                  onTap: () {},
                                  dense: true,
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(user!.name),
                                      const SizedBox(height: 10),
                                      Text(user!.province),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {},
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
                                      setState(() {
                                        final newPhoneNumber =
                                            phoneNumberController.text;
                                        final userId = user!.id;
                                        final token = user!.token;

                                        final verifyPhoneNumberEvent =
                                            VerifyPhoneNumberEvent(
                                                userId, newPhoneNumber, token);
                                        sl<UserBloc>()
                                            .add(verifyPhoneNumberEvent);

                                        isEditPhoneNumber = false;
                                      });
                                    },
                                    icon: const Icon(Icons.check),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                        ]),
                      ));
                    },
                  ),
                ),
              ));
  }
}
