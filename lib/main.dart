import 'package:admin_apps/cloud_firestore/add_data.dart';
import 'package:admin_apps/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panel Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdminPanel(),
    );
  }
}
