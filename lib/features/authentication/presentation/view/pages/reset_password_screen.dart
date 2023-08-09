import 'package:auto_route/auto_route.dart';
import 'package:event_management_system/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../core/injection/injection_container.dart';


import '../../../../../core/utils/custom_text_field.dart';
import '../../logic/bloc/authentication_bloc.dart';
@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  final String verificationCode;
  final String code;

  const ResetPasswordScreen({
    Key? key,
    required this.verificationCode,
    required this.code,
  }) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _submitForm(BuildContext context) {
    final verificationCode = _verificationCodeController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match'),
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
      return;
    }
    if (verificationCode != widget.verificationCode) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid verification code'),
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
      return;
    }
    final authenticationBloc = sl<AuthenticationBloc>();
    authenticationBloc.add(
      VerifyPhoneResetPasswordRequested(
        code: widget.code,
        verificationCode: widget.verificationCode,
        newPassword: newPassword,
      ),
    );

    authenticationBloc.stream.listen((state) {
      if (state is ResetPasswordSuccess) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Reset Password'),
              content: const Text('You have set a new password successfully'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.router.popAndPush(const AuthRoute());
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (state is ResetPasswordFailure) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please try again with valid data'),
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 35, 47, 103),
            size: 18,
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          toolbarHeight: 40,
          elevation: 0,
          title: const Text(
            'Reset Password',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 35, 47, 103),
              fontFamily: 'Lily_Script_One',
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded
            
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  labelText: 'Verification Code',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Verification code is required';
                    }
                    return null;
                  },
                  controller: _verificationCodeController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Password',
                  onChanged: (value) {
                    // Handle confirm password change here
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  controller: _newPasswordController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Confirm Password',
                  onChanged: (value) {
                    // Handle confirm password change here
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password is required';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  obscureText: !_isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible =
                            !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  controller: _confirmPasswordController,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _submitForm(context);
                    }
                  },
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 47, 103),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
