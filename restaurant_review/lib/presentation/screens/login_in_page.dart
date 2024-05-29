import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/auth/auth_event.dart';
import 'package:restaurant_review/application/auth/auth_providers.dart';
import 'package:restaurant_review/application/auth/auth_state.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';

class LogInPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LogInPage(),
      );

  const LogInPage({super.key});

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin() {
    if (formKey.currentState!.validate()) {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      authNotifier.handleEvent(
        AuthLoginRequested(
          emailController.text,
          passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        print(next.user.role);
        if (next.user.role == 'admin') {
          Navigator.pushNamed(context, '/adminprofile');
        } else {
          Navigator.pushNamed(context, '/entry');
        }
      } else if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

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
                hintText: "Username",
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
                onPressed: handleLogin,
              ),
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
                    text: "Don't have an account?",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
