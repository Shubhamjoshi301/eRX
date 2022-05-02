import 'package:erx/handlers/user_type_handler.dart';
import 'package:erx/screens/login_screen.dart';
import 'package:erx/widgets/customer_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHandler extends StatelessWidget {
  AuthHandler({Key? key}) : super(key: key);
  final _authStream = FirebaseAuth.instance.authStateChanges();
  final _spFuture = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authStream,
      builder: (context, snapshot) {
        // If user is logged in
        if (snapshot.hasData && !snapshot.data!.isAnonymous) {
          return FutureBuilder<SharedPreferences>(
            future: _spFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Provider<SharedPreferences>(
                  create: (context) {
                    return snapshot.data!;
                  },
                  builder: (context, _) {
                    return const UserTypeHandler();
                  },
                );
              } else {
                return const CustomLoader();
              }
            },
          );
        }
        // If user is not Logged in
        else {
          return LoginScreen();
        }
      },
    );
  }
}
