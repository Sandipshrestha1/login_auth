import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  TextEditingController email = TextEditingController();
  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Forget Password"),
        ),
        body: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Enter Email",
              ),
            ),
            ElevatedButton(
                onPressed: (() => reset()), child: const Text("Send link"))
          ],
        ));
  }
}
