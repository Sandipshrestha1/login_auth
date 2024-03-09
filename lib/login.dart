import 'package:authentication/forget.dart';
import 'package:authentication/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordObsecured = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("error messages", e.code);
    } catch (e) {
      Get.snackbar("error messages", e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Login"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(
                        hintText: 'Enter email', prefixIcon: Icon(Icons.email)),
                  ),
                  TextField(
                    obscureText: passwordObsecured,
                    controller: password,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordObsecured = !passwordObsecured;
                          });
                        },
                        icon: Icon(
                          passwordObsecured
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (() => signIn()),
                    child: const Text("Login"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: (() => Get.to(const SignupScreen())),
                    child: const Text("Register now"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: (() => Get.to(const Forget())),
                    child: const Text("Forget Password ?"),
                  ),
                ],
              ),
            ),
          );
  }
}
