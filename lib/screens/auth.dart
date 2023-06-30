import 'package:chat_app/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  bool _isLogin = true;
  String enteredEmail = '';
  String enteredPassword = '';

  void onChangeLoginSignupMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('@')) {
      return 'Invalid email address.';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must have 6 or more characters.';
    }
    return null;
  }

  void _onSubmit(BuildContext context) {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    if (_isLogin) {
    } else {
      context.read<AuthBloc>().add(
            AuthSignInEvent(
              email: enteredEmail,
              password: enteredPassword,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Image.asset('./assets/chat.png'),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Email address'),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) => _emailValidator(value),
                              onSaved: (newValue) {
                                enteredEmail = newValue!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Password'),
                              ),
                              obscureText: true,
                              validator: (value) => _passwordValidator(value),
                              onSaved: (newValue) {
                                enteredPassword = newValue!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              onPressed: () {
                                //context.read<AuthBloc>().add(AuthSignInEvent());
                                _onSubmit(context);
                              },
                              child: Text(
                                _isLogin ? 'Login' : 'Sign up',
                              ),
                            ),
                            TextButton(
                              onPressed: onChangeLoginSignupMode,
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'I already have an account'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
