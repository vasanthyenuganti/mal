// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mal/utills/app_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  color: MediaQuery.of(context).platformBrightness.index == 1
                      ? AppColors.buttonBackgroundLight
                      : AppColors.primaryBackgroundLight,
                  height: 200,
                  width: 200,
                )),
              ),
              const SizedBox(
                height: 24,
              ),
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
              SizedBox(
                height: 55,
                child: _isLoading
                    ? const Center(child: CupertinoActivityIndicator())
                    : ElevatedButton(
                        onPressed: _onSubmit,
                        child: const Text(
                          'SignUp',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              ),
              const SizedBox(height: 24),
              RichText(
                textAlign: TextAlign.center,
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Already have an account ?  ",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                TextSpan(
                    text: "Login",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
                    style: const TextStyle(
                        fontSize: 18, color: AppColors.buttonBackgroundLight))
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
