import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreden/screens/dashboard/main_dashboard.dart';
import 'package:exploreden/screens/profile/interest_screen.dart';
import 'package:exploreden/services/auth_service.dart';
import 'package:exploreden/services/database_service.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:exploreden/utils/controllers.dart';
import 'package:exploreden/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 395,
              height: 439,
              decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                      blurRadius: 0.2, spreadRadius: 0.5, color: Colors.grey)
                ],
                color: colorWhite,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(150),
                    bottomRight: Radius.circular(150),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/owl.png",
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    "Welcome To Explorer Den",
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            _isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SocialLoginButton(
                      buttonType: SocialLoginButtonType.google,
                      onPressed: () async {
                        setState(() {
                          _isloading = true;
                        });
                        await DatabaseMethods()
                            .signInWithGoogle()
                            .then((value) async {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set({
                            "photoURL": FirebaseAuth
                                .instance.currentUser!.photoURL
                                .toString(),
                            "email": FirebaseAuth.instance.currentUser!.email,
                            "name":
                                FirebaseAuth.instance.currentUser!.displayName,
                            "phoneNumber": FirebaseAuth
                                .instance.currentUser!.phoneNumber
                                .toString(),
                            "uid": FirebaseAuth.instance.currentUser!.uid
                          });
                        });
                        setState(() {
                          _isloading = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => InterestScreen()));
                      },
                      imageWidth: 20,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  signUpUsers() async {
    setState(() {
      _isloading = true;
    });
    String rse = await AuthMethods().loginInUser(
      email: loginEmailControllers.text,
      pass: loginPasswordControllers.text,
    );

    print(rse);
    setState(() {
      _isloading = false;
    });
    if (rse != 'sucess') {
      showSnakBar(rse, context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainDashboard()));
    }
  }
}
