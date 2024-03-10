import 'package:authentication/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  bool passwordObsecured = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Get.offAll(const Wrapper());
    } catch (e) {
      // Print error message
      print('Signup Error: $e');
      // Show an error dialog or message to the user
      showDialog(
        builder: (context) => AlertDialog(
          title: const Text('Signup Error'),
          content: Text('$e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
        context: context,
      );
    }
  }

  @override
  void dispose() {
    // Dispose of text editing controllers
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: "Enter email"),
            ),
            TextField(
              obscureText: passwordObsecured,
              controller: password,
              decoration: InputDecoration(
                hintText: "Enter password",
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordObsecured = !passwordObsecured;
                    });
                  },
                  icon: Icon(
                    passwordObsecured ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => signup(),
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
