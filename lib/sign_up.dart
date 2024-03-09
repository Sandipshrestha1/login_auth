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

  // signup() async {
  //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email.text, password: password.text);
  //   Get.ofAll(Wrapper());
  // }

  signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, password: password.text);
    Get.offAll(const Wrapper());
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
          //mainAxisAlignment: MainAxisAlignment.center,
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
                        passwordObsecured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ))),
            ),
            ElevatedButton(
                onPressed: (() => signup()), child: const Text("SignUp"))
          ],
        ),
      ),
    );
  }
}
