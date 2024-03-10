import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart'; // Assuming you're using GetX for state management

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    super.initState();
    sendVerifyLink();
  }

  void sendVerifyLink() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      Get.snackbar('Link sent', 'A link has been sent to your email',
          margin: const EdgeInsets.all(30),
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Already Verified', 'Your email is already verified',
          margin: const EdgeInsets.all(30),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void reload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        // Redirect user to some other screen if email is verified
        // Example: Get.offAll(HomeScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(28.0),
        child: Text(
            "open your mail nad click on the link provided to verify email and reload this page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => reload()),
        child: const Icon(Icons.restart_alt_rounded),
      ),
    ); // Placeholder widget can be replaced with your UI
  }
}
