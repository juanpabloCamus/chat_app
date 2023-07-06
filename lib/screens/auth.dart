import 'package:chat_app/bloc/auth_bloc.dart';
import 'package:chat_app/utils/show_snackbar.dart';
import 'package:chat_app/validators/auth_validators.dart';
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

  void _onSubmit() {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    if (_isLogin) {
      context.read<AuthBloc>().add(
            AuthSignUpEvent(
              email: enteredEmail,
              password: enteredPassword,
            ),
          );
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
  Widget build(BuildContext widgetContext) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (listenerContext, state) {
        if (state is AuthErrorState) {
          showSnackBar(listenerContext, state.message, Colors.red);
        }
        if (state is AuthSignUpState) {
          showSnackBar(listenerContext, state.message, Colors.green);
        }
        if (state is AuthenticatedState) {
          print(state.user);
        }
      },
      builder: (builderContext, state) {
        return Scaffold(
          backgroundColor: Theme.of(builderContext).colorScheme.primary,
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
                              validator: (value) => emailValidator(value),
                              onSaved: (newValue) {
                                enteredEmail = newValue!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Password'),
                              ),
                              obscureText: true,
                              validator: (value) => passwordValidator(value),
                              onSaved: (newValue) {
                                enteredPassword = newValue!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(builderContext)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              onPressed: () {
                                _onSubmit();
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
