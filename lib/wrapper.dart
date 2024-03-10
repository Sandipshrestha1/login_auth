// import 'package:authentication/homepage.dart';
// import 'package:authentication/login.dart';
// import 'package:authentication/verify.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Wrapper extends StatefulWidget {
//   const Wrapper({super.key});

//   @override
//   State<Wrapper> createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             // ignore: avoid_print
//             print(snapshot.data);
//             if (snapshot.data!.emailVerified) {
//               return const HomePage();
//             } else {
//               return const Verify();
//             }
//           } else {
//             return const Login();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:authentication/homepage.dart';
import 'package:authentication/login.dart';
import 'package:authentication/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap with MaterialApp
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${snapshot.error}')),
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              });
              return const SizedBox();
            } else if (snapshot.hasData) {
              final User? user = snapshot.data;
              if (user != null) {
                if (user.emailVerified) {
                  return const HomePage();
                } else {
                  return const Verify();
                }
              } else {
                return const Login();
              }
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
