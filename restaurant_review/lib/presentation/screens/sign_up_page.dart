import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/auth/auth_event.dart';
import 'package:restaurant_review/application/auth/auth_providers.dart';
import 'package:restaurant_review/application/auth/auth_state.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';

enum UserType { owner, user }

class SignUpPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );

  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  UserType? _selectedUserType;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleSignUp() {
    if (formKey.currentState!.validate()) {
      if (_selectedUserType != null) {
        final authNotifier = ref.read(authNotifierProvider.notifier);
        authNotifier.handleEvent(
          AuthSignUpRequested(
            nameController.text,
            emailController.text,
            passwordController.text,
            _selectedUserType == UserType.owner ? 'owner' : 'user',
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a user type')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        Navigator.push(context, LogInPage.route());
      } else if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

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
                      value: UserType.user,
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
                  onPressed: handleSignUp,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
