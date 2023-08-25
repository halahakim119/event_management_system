import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../logic/bloc/authentication_bloc.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form key to identify and control the login form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller for the phone number text field
  final TextEditingController _phoneNumberController = TextEditingController();

  // Controller for the password text field
  final TextEditingController _passwordController = TextEditingController();

  // Flag to toggle the visibility of the password
  bool _isPasswordVisible = false;

  // Submit the login form
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Dispatch the sign-in event with the entered phone number and password
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignInWithPhoneRequested(
          phoneNumber: _phoneNumberController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  // Show an error dialog with the provided error message
  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          // Listen to authentication state changes
          listener: (context, state) {
            if (state is AuthenticationSigninFailure) {
              _showErrorDialog(
                  context, state.errorMessage); // Display the error message
            } else if (state is AuthenticationSigninSuccess) {
              context.router.popAndPush(const MainRoute());
            }
          },
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              // Show loading indicator if authentication is in progress
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      _buildPhoneNumberTextField(), // Phone number text field
                      const SizedBox(height: 16),
                      _buildPasswordTextField(), // Password text field
                      const SizedBox(height: 16),
                      _buildLoginButton(context), // Login button
                      const SizedBox(height: 16.0),

                      _buildForgotPasswordButton(
                          context), // Forgot password button
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

  // Builds the phone number text field
  Widget _buildPhoneNumberTextField() {
    return CustomTextField(
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
      keyboardType: TextInputType.phone,
      controller: _phoneNumberController,
    );
  }

  // Builds the password text field
  Widget _buildPasswordTextField() {
    return CustomTextField(
      labelText: LocaleKeys.Password.tr(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        return null;
      },
      obscureText: !_isPasswordVisible,
      suffixIcon: IconButton(
        icon:
            Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          _isPasswordVisible = !_isPasswordVisible;
          setState(() {});
        },
      ),
      controller: _passwordController,
    );
  }

  // Builds the login button
  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      child: Text(LocaleKeys.Login.tr()),
      onPressed: () => _submitForm(context),
    );
  }

  // Builds the forgot password button
  Widget _buildForgotPasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () => context.router.push(ForgotPasswordRoute()),
      child: Text(
        LocaleKeys.Forgot_Password.tr(),
      ),
    );
  }

  // Checks if a string is numeric
  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
