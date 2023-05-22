import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return LoginPage();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Lista Ekspresowa'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.abc_outlined),
            ),
            body: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Witaj! ${user.email}'),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Wyloguj się'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.cyanAccent,
                  ),
                  transform: Matrix4.rotationZ(0.05),
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(10),
                  child: const Text('Przykład 1'),
                ),
              ],
            ),
          );
        });
  }
}
