import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/bloc/auth_bloc.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        )
      ],
      child: const App(),
    ),
  );
}

final firebaseAuthStream = FirebaseAuth.instance.authStateChanges();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (blocContext, state) {
        return MaterialApp(
          title: 'FlutterChat',
          theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 63, 17, 177)),
          ),
          home: StreamBuilder(
            stream: firebaseAuthStream,
            builder: (streamContext, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              }

              if (snapshot.hasData && snapshot.data != null) {
                context.read<AuthBloc>().emit(
                      AuthenticatedState(user: snapshot.data!),
                    );
                return const ChatScreen();
              }
              context.read<AuthBloc>().emit(
                    AuthUnathenticatedState(),
                  );
              return const AuthScreen();
            },
          ),
        );
      },
    );
  }
}
