import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/utils/custom_text_field.dart';
import '../../logic/bloc/authentication_bloc.dart';
@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _phoneNumberController =
      TextEditingController(text: '+964');

  ForgotPasswordScreen({super.key});

  void _submitForm(BuildContext context) {
    final phoneNumber = _phoneNumberController.text.trim();
    BlocProvider.of<AuthenticationBloc>(context).add(
      ResetPasswordRequested(phoneNumber: phoneNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: Scaffold(
        appBar: AppBar(
        
      
          title: const Text(
            'forgot Password',
         
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is VerifyPhoneNumber) {
              print(state.verificationCode);
              context.router.push(ResetPasswordRoute(
                verificationCode: state.verificationCode,
                code: state.code,
              ));
            } else if (state is ResetPasswordFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.errorMessage),
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
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    labelText: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      final enteredNumber = value.trim();
                      final phoneNumber =
                          '+964${enteredNumber.substring(4)}'; // Append the entered number excluding the prefix
                      _phoneNumberController.value =
                          _phoneNumberController.value.copyWith(
                        text: phoneNumber,
                        selection: TextSelection.collapsed(
                          offset: phoneNumber.length,
                        ),
                      );
                    },
                    validator: (value) {
                      if (value!.length <= 4) {
                        return 'Phone number is required';
                      }
                      if (value.length > 15) {
                        return 'Phone number should be 10 numbers only';
                      }
                      if (!isNumeric(value)) {
                        return 'Phone number must contain only numbers';
                      }
                      return null;
                    },
                    controller: _phoneNumberController,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => _submitForm(context),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Color.fromARGB(255, 35, 47, 103),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
