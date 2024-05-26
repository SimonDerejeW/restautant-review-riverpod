import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';

enum UserType { owner, customer }

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  UserType? _selectedUserType;

  @override
  Widget build(BuildContext context) {
    // formKey.currentState!.validate();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthField(
                  hintText: "Email",
                  controller: emailController,
                ),
                const SizedBox(
                  height: 15,
                ),
                AuthField(
                  hintText: "Password",
                  controller: passwordController,
                  isObscure: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Owner'),
                    Radio<UserType>(
                      activeColor: AppPallete.gradient3,
                      value: UserType.owner,
                      groupValue: _selectedUserType,
                      onChanged: (UserType? value) {
                        setState(() {
                          _selectedUserType = value;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text('Customer'),
                    Radio<UserType>(
                      activeColor: AppPallete.gradient3,
                      value: UserType.customer,
                      groupValue: _selectedUserType,
                      onChanged: (UserType? value) {
                        setState(() {
                          _selectedUserType = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthGradientButton(
                  buttonText: "Sign Up",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('Signed Up');
                      Navigator.push(
                        context,
                        LogInPage.route(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      LogInPage.route(),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: ' Sign In',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient3,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
