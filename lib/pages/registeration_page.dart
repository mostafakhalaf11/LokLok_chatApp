

// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loklokapp/pages/chat_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helpers/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form_textfield.dart';

class RegisterationPage extends StatefulWidget {
   const RegisterationPage({super.key});
  static String id = 'RegisterationPage';

  @override
  State<RegisterationPage> createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
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
                      'Register',
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
                        await registerUser();
                        showSnackBar(context, 'Account Created successfully');
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        // print("Khalaf exception   ${ex.code}");
                        if (ex.code == 'weak-password') {
                          showSnackBar(context, 'Weak Password');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(context,
                              'Email already in use by another account');
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
                  buttonLabel: 'Sign Up',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account ",
                      style: TextStyle(
                          fontSize: 16,
                          color: kTextColor,
                          fontFamily: 'Inter'),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "LogIn",
                        style: const TextStyle(
                            color: Colors.yellow,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
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


  Future<void> registerUser() async {
     await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
