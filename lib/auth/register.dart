import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool secureText = true;
  String role = 'Student';

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future<void> registerUser() async {
    if (formState.currentState!.validate()) {
      try {
        // Create user in Firebase Auth
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        // Save user data in Firestore based on role
        if (role == 'Student') {
          await FirebaseFirestore.instance
              .collection('Students')
              .doc(credential.user!.uid)
              .set({
            'email': email.text,
            'uid': credential.user!.uid,
          });
        } else if (role == 'Teacher') {
          await FirebaseFirestore.instance
              .collection('Teachers')
              .doc(credential.user!.uid)
              .set({
            'email': email.text,
            'uid': credential.user!.uid,
          });
        }

        // Navigate to the appropriate homepage
        Navigator.of(context).pushReplacementNamed(
            role == 'Student' ? 'studenthomepage' : 'teacherhomepage');
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'weak-password':
            errorMessage =
                'The password is too weak. Please use a stronger password.';
            break;
          case 'email-already-in-use':
            errorMessage =
                'The email is already registered. Please use a different email.';
            break;
          case 'invalid-email':
            errorMessage =
                'The email address is invalid. Please enter a valid email.';
            break;
          case 'operation-not-allowed':
            errorMessage =
                'Email/password accounts are not enabled. Contact support.';
            break;
          case 'network-request-failed':
            errorMessage =
                'A network error occurred. Please check your internet connection.';
            break;
          default:
            errorMessage = 'Registration failed. Please try again.';
            break;
        }

        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: errorMessage,
        ).show();
        print('FirebaseAuth Error: ${e.code}');
      } on FirebaseException catch (e) {
        String errorMessage = 'Firestore error: ${e.message}';
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: errorMessage,
        ).show();
        print('Firestore Error: ${e.code}');
      } catch (e) {
        String errorMessage = 'An unexpected error occurred. Please try again.';
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: errorMessage,
        ).show();
        print('Unexpected Error: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, const Color.fromARGB(255, 228, 230, 252)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 50),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: Image.asset(
                        "assets/Logo.png",
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(height: 20),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 41, 114),
                    ),
                  ),
                  Container(height: 10),
                  const Text(
                    "Register To Continue Using The App",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(height: 20),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 8, 41, 114),
                    ),
                  ),
                  Container(height: 10),
                  TextFormField(
                    validator: (val) {
                      if (val == null ||
                          !RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(val)) {
                        return "Please Enter A Valid Email";
                      }
                      return null;
                    },
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 184, 184, 184)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 8, 41, 114), width: 1),
                      ),
                    ),
                  ),
                  Container(height: 10),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 8, 41, 114),
                    ),
                  ),
                  Container(height: 10),
                  TextFormField(
                    validator: (val) {
                      if (val == '') {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                    controller: password,
                    obscureText: secureText,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 184, 184, 184)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 8, 41, 114), width: 1),
                      ),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        onPressed: () {
                          setState(() {
                            secureText = !secureText;
                          });
                        },
                        icon: Icon(secureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                  Container(height: 10),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 8, 41, 114),
                    ),
                  ),
                  Container(height: 10),
                  TextFormField(
                    validator: (val) {
                      if (val != password.text) {
                        return "Passwords Do Not Match";
                      }
                      return null;
                    },
                    controller: confirmPassword,
                    obscureText: secureText,
                    decoration: InputDecoration(
                      hintText: "Confirm Your Password",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 184, 184, 184)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 8, 41, 114), width: 1),
                      ),
                    ),
                  ),
                  Container(height: 10),
                  const Text(
                    "Role",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 8, 41, 114),
                    ),
                  ),
                  Container(height: 10),
                  DropdownButtonFormField<String>(
                    value: role,
                    items: ['Student', 'Teacher'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        role = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 184, 184, 184)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 8, 41, 114), width: 1),
                      ),
                    ),
                  ),
                  Container(height: 20),
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Color.fromARGB(255, 8, 41, 114),
                    textColor: Colors.white,
                    onPressed: registerUser,
                    child: Text(
                      "Register",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Container(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('login');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 8, 41, 114),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
