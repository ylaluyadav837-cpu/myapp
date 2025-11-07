
import 'package:flutter/material.dart';
import 'package:padosi/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _error = '';
  String? _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (result == null) {
                      setState(() {
                        _error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                },
                child: const Text('Sign in with Email'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    dynamic result = await _auth.signUpWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (result == null) {
                      setState(() {
                        _error = 'Please supply a valid email';
                      });
                    }
                  }
                },
                child: const Text('Sign up with Email'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  dynamic result = await _auth.signInWithGoogle();
                  if (result == null) {
                    setState(() {
                      _error = 'Could not sign in with Google';
                    });
                  }
                },
                icon: const Icon(Icons.login),
                label: const Text('Sign in with Google'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _auth.verifyPhoneNumber(
                    _phoneController.text,
                    (cred) async {
                      // Auto-retrieval
                    },
                    (e) {
                      setState(() {
                        _error = e.message ?? 'Failed to verify phone number';
                      });
                    },
                    (verificationId, forceResendingToken) {
                      setState(() {
                        _verificationId = verificationId;
                      });
                    },
                    (verificationId) {
                      setState(() {
                        _verificationId = verificationId;
                      });
                    },
                  );
                },
                child: const Text('Send OTP'),
              ),
              const SizedBox(height: 20),
              if (_verificationId != null)
                Column(
                  children: [
                    TextFormField(
                      controller: _smsController,
                      decoration: const InputDecoration(labelText: 'OTP'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        dynamic result = await _auth.signInWithPhoneNumber(
                          _verificationId!,
                          _smsController.text,
                        );
                        if (result == null) {
                          setState(() {
                            _error = 'Failed to sign in with phone number';
                          });
                        }
                      },
                      child: const Text('Sign in with Phone'),
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              Text(
                _error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
