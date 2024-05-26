import 'package:flutter/material.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';

class LogInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInPage(),
      );

  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // formKey.currentState!.validate();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
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
                height: 20,
              ),
              AuthGradientButton(
                  buttonText: "Sign In",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print("Sign In");
                    }
                    Navigator.pushNamed(context, '/entry');
                  }),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    SignUpPage.route(),
                  ),
                },
                child: RichText(
                  text: TextSpan(
                    text: "Dont't have an account?",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: ' Sign Up',
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
    );
  }
}
