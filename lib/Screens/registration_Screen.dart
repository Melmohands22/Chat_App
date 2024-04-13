import 'package:chat_app/constant.dart';
import 'package:chat_app/widgets/customButton.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:chat_app/widgets/showSnckBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class registrationScreen extends StatefulWidget {
  registrationScreen({super.key});

  static String id = 'registrationScreen';

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {
  bool isLoading = false;

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KpraimaryColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'My Chat',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const Row(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PasswordTextField(
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'passward',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PasswordTextField(
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Confirm passward',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onTab: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await registerUser();
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context, 'weak-password');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context, 'email-already-in-use');
                          }
                        } catch (e) {
                          showSnackBar(context, 'there was an error!');
                        }

                        isLoading = false;
                        setState(() {});
                      } else {}
                    },
                    title: 'Register',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'already have account ? ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  Log In',
                        style:
                            TextStyle(color: Color(0xffc7ede6), fontSize: 16),
                      ),
                    ),
                  ])
                ],
              ),
            )),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
