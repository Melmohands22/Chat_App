import 'package:chat_app/Screens/chat_Screen.dart';
import 'package:chat_app/Screens/registration_Screen.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/widgets/customButton.dart';
import 'package:chat_app/widgets/customTextField.dart';
import 'package:chat_app/widgets/showSnckBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class loginScreen extends StatefulWidget {
  loginScreen({super.key});
  static String id = 'loginScreen';

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String? email, password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
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
                    height: 100,
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Log In',
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
                  CustomButton(
                    onTab: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();

                          Navigator.pushNamed(context, chatScreen.id,
                              arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context, 'No user found for that email');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context, 'wrong-password');
                          }
                        } catch (e) {
                          showSnackBar(context, 'there was an error!');
                        }

                        isLoading = false;
                        setState(() {});
                      } else {}
                    },
                    title: 'Log In',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'don\'t have email ? ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, registrationScreen.id);
                      },
                      child: const Text(
                        '  Register',
                        style:
                            TextStyle(color: Color(0xffc7ede6), fontSize: 16),
                      ),
                    ),
                  ])
                ],
              ),
            ),
          )),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
