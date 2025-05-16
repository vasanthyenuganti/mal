// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mal/services/auth_service.dart';
import 'package:mal/utills/app_colors.dart';
import 'package:mal/view/auth/forgot_password_Screen.dart';
import 'package:mal/view/auth/signup_screen.dart';
import 'package:mal/view/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "app_icon",
                child: Center(
                  child: SvgPicture.asset(
                    'assets/app_icon.svg',
                    color:
                        MediaQuery.of(context).platformBrightness.index == 1
                            ? AppColors.buttonBackgroundLight
                            : AppColors.primaryBackgroundLight,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot Password?"),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 55,
                child:
                    _isLoading
                        ? const Center(child: CupertinoActivityIndicator())
                        : ElevatedButton(
                          onPressed: _onSubmit,
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Create new account ?  ",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextSpan(
                      text: "SignUp",
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => const SignupScreen(),
                                ),
                              );
                            },
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.buttonBackgroundLight,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                 
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white),
                  ),
                  height: 52,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image(image: NetworkImage("")),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () async {
                  // await AuthService().nativeGoogleSignIn();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white),
                  ),
                  height: 52,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image(image: NetworkImage("")),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      Text(
                        "Sign in with Apple",
                        style: TextStyle(color: Colors.white),
                      ),
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
