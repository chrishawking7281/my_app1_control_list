import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return LoginPage();
          }
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Nieoczekiwany error :()'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Text('Ładowanie danych trwa dłużej niż zwykle'));
                }
                final documents = snapshot.data!.docs;

                return Scaffold(
                  appBar: AppBar(
                    foregroundColor: Colors.black,
                    title: const Center(child: Text('Lista Ekspresowa')),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('categories').add({
                        'title': controller.text,
                      });
                      controller.clear();
                    },
                    child: const Icon(Icons.abc_outlined),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        const SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                style: GoogleFonts.lifeSavers(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                                'Witaj! ${user.email}'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                              },
                              child: const Text('Wyloguj się'),
                            ),
                          ],
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              hintText: 'Co masz do zrobienia?'),
                          controller: controller,
                        ),
                        const SizedBox(height: 15),
                        for (final document in documents) ...[
                          Dismissible(
                            key: ValueKey(document.id),
                            onDismissed: (_) {
                              FirebaseFirestore.instance
                                  .collection('categories')
                                  .doc(document.id)
                                  .delete();
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.cyanAccent,
                              ),
                              transform: Matrix4.rotationZ(0.05),
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                  style: GoogleFonts.lifeSavers(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  document['title'].toString()),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
