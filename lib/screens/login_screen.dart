import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_access/screens/next_screen_2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController logInIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phNoController = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Email id"),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: logInIdController,
                // validator: (values) {
                //   if (values == "alwin@gmail.com") {
                //     return null;
                //   } else {
                //     return "please enter correct details";
                //   }
                // },
              ),
              const SizedBox(height: 30),
              const Text("Phone No"),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: phNoController,
                // validator: (values) {
                //   if (values == "8056527428") {
                //     return null;
                //   } else {
                //     return "please enter correct Phone number";
                //   }
                // },
              ),
              const SizedBox(height: 30),
              const Text("Password"),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 8,
                obscuringCharacter: "*",
                // validator: (value) {
                //   if (value == "12345678") {
                //     return null;
                //   } else {
                //     return "Please Enter correct number";
                //   }
                // },
              ),
              const SizedBox(height: 30),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        validation();
                        var emailId = logInIdController.text;
                        var phoneNo = phNoController.text;
                        var passWord = passwordController.text;
                        FirebaseFirestore.instance.collection(emailId);
                        logInIdController.clear();
                        phNoController.clear();
                        passwordController.clear();
                      },
                      child: const Text("login")))
            ],
          ),
        ),
      ),
    );
  }

  screenNavigation() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NextScreen2()));
  }

  validation() {
    if (key.currentState!.validate()) {
      screenNavigation();
    }
  }
}
