import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';
import 'package:restaurant_review/presentation/view_models/auth_view_model.dart';

enum UserType { owner, customer }

class SignUpPage extends ConsumerWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (context) => const SignUpPage(),
    );
  }

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final userType = StateProvider<UserType?>((ref) => null);

    final authViewModel = ref.read(authNotifierProvider.notifier);
    final state = ref.watch(authNotifierProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100),
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
                const SizedBox(height: 30),
                AuthField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: "Email",
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: "Password",
                  controller: passwordController,
                  isObscure: true,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Owner'),
                    Radio<UserType>(
                      activeColor: AppPallete.gradient3,
                      value: UserType.owner,
                      groupValue: ref.watch(userType),
                      onChanged: (UserType? value) {
                        ref.read(userType.notifier).state = value;
                      },
                    ),
                    const SizedBox(width: 20),
                    const Text('Customer'),
                    Radio<UserType>(
                      activeColor: AppPallete.gradient3,
                      value: UserType.customer,
                      groupValue: ref.watch(userType),
                      onChanged: (UserType? value) {
                        ref.read(userType.notifier).state = value;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AuthGradientButton(
                  buttonText: "Sign Up",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final selectedUserType = ref.read(userType);
                      if (selectedUserType != null) {
                        final userTypeString =
                            selectedUserType == UserType.owner
                                ? 'owner'
                                : 'user';
                        await authViewModel.signUpUser(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          userTypeString,
                        );

                        if (state.user != null) {
                          Navigator.pushNamed(context, '/entry');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Sign Up failed. Please try again.'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a user type.'),
                          ),
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, LogInPage.route());
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
