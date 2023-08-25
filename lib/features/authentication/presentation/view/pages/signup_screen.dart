import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/strings/strings.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../logic/bloc/authentication_bloc.dart';

@RoutePage()
// Define the SignupScreen widget as a StatefulWidget
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

// Define the state for the SignupScreen widget
class _SignupScreenState extends State<SignupScreen> {
  // Create a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Create controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Define boolean variables for password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  // Function to get the English province name from the Arabic province name
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
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignUpWithPhoneRequested(
          name: _nameController.text.trim(),
          province: selectedProvince,
          phoneNumber: _phoneNumberController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          // Listen for changes in the AuthenticationBloc state
          listener: (context, state) {
            if (state is AuthenticationSignupFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Signup Error'),
                    content:
                        Text(state.errorMessage), // Display the error message
                    actions: [
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
            } else if (state is VerifyPhoneNumber) {
              // Navigate to the verification screen if phone number verification is required
              log(state.verificationCode);
              context.router.push(VeificationRoute(
                verificationCode: state.verificationCode,
                code: state.code,
              ));
            }
          },
          // Build the UI based on the AuthenticationBloc state
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      _buildNameTextField(),
                      const SizedBox(height: 16),
                      _buildPhoneNumberTextField(),
                      const SizedBox(height: 16),
                      _buildPasswordTextField(),
                      const SizedBox(height: 16),
                      _buildConfirmPasswordTextField(),
                      const SizedBox(height: 24),
                      Align(
                          alignment: Alignment.center,
                          child: Text(LocaleKeys.Where_do_you_live.tr())),
                      _buildProvinceTextField(),
                      const SizedBox(height: 24),
                      _buildSignUpButton(context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Build the name text field widget
  Widget _buildNameTextField() {
    return CustomTextField(
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
    );
  }

// Build the name text field widget
  Widget _buildProvinceTextField() {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(25),
      items: getProvinces().map((province) {
        return DropdownMenuItem<String>(
          value: province,
          child: Text(province),
        );
      }).toList(),
      onChanged: (selectedValue) {
        setState(() => _provinceController.text = selectedValue ?? '');
      },
      decoration: InputDecoration(
        labelText: LocaleKeys.Province.tr(),
      ),
    );
  }

  // Build the phone number text field widget
  Widget _buildPhoneNumberTextField() {
    return CustomTextField(
      max: 15,
      keyboardType: TextInputType.phone,
      labelText: LocaleKeys.Phone_Number.tr(),
      validator: (value) {
        if (value!.length <= 4) {
          return 'Phone number is required';
        }
        if (!value.startsWith('+964')) {
          return 'Phone number should start with +964';
        }
        if (!isNumeric(value)) {
          return 'Phone number must contain only numbers';
        }
        return null;
      },
      controller: _phoneNumberController,
    );
  }

  // Build the password text field widget
  Widget _buildPasswordTextField() {
    return CustomTextField(
      labelText: LocaleKeys.Password.tr(),
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      obscureText: !_isPasswordVisible,
      suffixIcon: IconButton(
        icon: Icon(
          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _isPasswordVisible = !_isPasswordVisible;
          });
        },
      ),
      controller: _passwordController,
    );
  }

  // Build the confirm password text field widget
  Widget _buildConfirmPasswordTextField() {
    return CustomTextField(
      labelText: LocaleKeys.Confirm_Password.tr(),
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm password is required';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      obscureText: !_isConfirmPasswordVisible,
      suffixIcon: IconButton(
        icon: Icon(
          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
          });
        },
      ),
      controller: _confirmPasswordController,
    );
  }

  // Build the sign up button widget
  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      child: Text(LocaleKeys.Sign_Up.tr()),
      onPressed: () => _submitForm(context),
    );
  }

  // Check if a string is numeric
  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
