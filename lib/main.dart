import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control List',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.cyanAccent,
            ),
            transform: Matrix4.rotationZ(0.05),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            child: const Text('Przykład 1'),
          )
        ],
      ),
    );
  }
}
