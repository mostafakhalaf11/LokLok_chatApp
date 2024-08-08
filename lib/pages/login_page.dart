
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loklokapp/pages/registeration_page.dart';
import 'package:loklokapp/widgets/custom_button.dart';
import 'package:loklokapp/widgets/custom_form_textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helpers/show_snack_bar.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar:  AppBar(
          backgroundColor: kPrimaryColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text(
          'LOKLOK',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: kTextColor),
        ),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 120,
                ),
                SizedBox(
                    height: 200, child: Image.asset(kLogo)),
                const Text(
                  'LOKLOK Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 34,
                      color: kTextColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                          fontSize: 22,
                          color: kTextColor,
                          fontFamily: 'Inter'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomFormTextfield(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                  validateMessage: 'Please enter your email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextfield(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                  validateMessage: 'Please enter your Password',
                  isPassword: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await signInUser();
                        showSnackBar(context, 'Logged In successfully');
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        // print("Khalaf exception   ${ex.code}");
                        if (ex.code == 'invalid-credential') {
                          showSnackBar(
                              context, 'Please check your email and password');
                        }else if(ex.code == 'invalid-email'){
                          showSnackBar(
                              context, 'Invalid Email');

                        }
                      }
                      isLoading = false;
                      setState(() {});
                    } else {
                      showSnackBar(context,
                          'Check validation of Email and Password');
                    }
                  },
                  buttonLabel: 'Login',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an Account ",
                      style: TextStyle(
                          fontSize: 16,
                          color: kTextColor,
                          fontFamily: 'Inter'),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Register",
                        style: const TextStyle(
                            color: Colors.yellow,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                (context), RegisterationPage.id);
                          },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
     await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
