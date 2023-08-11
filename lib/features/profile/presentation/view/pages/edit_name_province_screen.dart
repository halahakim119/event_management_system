// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/strings/strings.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../data/models/user_profile_model.dart';
import '../../logic/bloc/user_bloc.dart';

@RoutePage()
class EditNameProvinceScreen extends StatefulWidget {
  final UserProfileModel user;

  const EditNameProvinceScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditNameProvinceScreen> createState() => _EditNameProvinceScreenState();
}

class _EditNameProvinceScreenState extends State<EditNameProvinceScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController provinceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    provinceController.text = widget.user.province;
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>(),
      child: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
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
        }
        if (state is UserEdited) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('sucess'),
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
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
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
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DropdownButtonFormField<String>(
                    value: provinceController.text,
                    borderRadius: BorderRadius.circular(25),
                    items: provinces.map((province) {
                      return DropdownMenuItem<String>(
                        value: province,
                        child: Text(province),
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      setState(() {
                        provinceController.text = selectedValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: LocaleKeys.Province.tr(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select the province';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    child: Text('Update'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Get the selected province from the DropdownButtonFormField
                        String selectedProvince =
                            provinceController.text.trim();

                        // Convert the selected province to English if the current locale is Arabic
                        if (EasyLocalization.of(context)!.locale ==
                            const Locale('ar')) {
                          selectedProvince =
                              getEnglishProvince(selectedProvince);
                        }

                        // Get the UserBloc from the context and dispatch the EditUserEvent
                        context.read<UserBloc>().add(
                              EditUserEvent(
                                widget.user.id,
                                widget.user.token,
                                nameController.text.trim(),
                                selectedProvince,
                              ),
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}