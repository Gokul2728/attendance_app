import 'dart:async';
import 'dart:developer';
import 'package:attendance/main.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workmanager/workmanager.dart';
import '../Common/request.dart';
import '../Packages/fade_transition/proste_route_animation.dart';
import '../Common/shared_pref.dart';
import '../Pages/home.dart';
import '../Utils/color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // LoginModule? loginModule;
  @override
  void initState() {
    // redirect();
    super.initState();
  }

  redirect() async {
    String? token = await StorageService().getStringData('token');

    bool isTokenEmpty = token?.isEmpty ?? true;

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isTokenEmpty ? const LoginPage() : const HomePage(),
        ),
        (route) => false,
      );
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.white,
            // color: mainColor,
          ),
          Center(
              child: Container(
            // height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              // shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/login.gif',
                fit: BoxFit.contain,
              ),
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                  child: Text.rich(
                    TextSpan(
                        text: 'Instruction:\n',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            // fontStyle: FontStyle.italic,
                            color: mainColor),
                        children: [
                          TextSpan(
                            text:
                                'Sign in with a stable internet connection to access the app. ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.grey.shade600),
                          ),
                          TextSpan(
                            text:
                                "Once logged in, you can manage attendance offline.\n",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade700),
                          ),
                          TextSpan(
                            text:
                                "Offline changes will sync automatically when you're back online or receive a notification to update attendance !",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                // decorationColor: textColor,
                                // decorationThickness: 2,
                                // decorationStyle: TextDecorationStyle.wavy,
                                backgroundColor: textColor.withOpacity(.1),
                                // decoration: TextDecoration.combine(
                                //     [TextDecoration.underline]),
                                color: mainColor),
                          )
                        ]),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  width: width,
                  height: 50,
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                  child: ElevatedButton(
                    onPressed: googleSignIn,
                    // onPressed: () async {
                    //   dynamic response = await apiGet(
                    //       path: '/auth/google?email=in7083@bitsathy.ac.in');
                    //   log(response.toString());
                    // },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      backgroundColor: mainColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Colors.grey.shade600, width: 0.6)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/google.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign In with Google",
                          style: TextStyle(
                              color: Colors.grey.shade200,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  googleSignIn() async {
    BotToast.showLoading();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        print(googleUser.displayName);
        print(googleUser.email.toString());
      } else {
        print('Google Sign-In canceled or failed');
        BotToast.closeAllLoading();
        return;
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      log(googleAuth.accessToken.toString());

      await StorageService().saveStringData(
          key: 'accessToken', data: googleAuth.accessToken.toString());

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // dynamic response =
        //     await apiGet(path: '/auth/google?email=${googleAuth.accessToken}');
        // log(response.toString());
        // loginModule = LoginModule.fromJson(response['data']);

        // await StorageService()
        //     .saveStringData(key: 'name', data: loginModule?.name ?? '');
        // await StorageService().saveStringData(
        //     key: 'profile_img', data: loginModule?.profileImg ?? '');
        // await StorageService()
        //     .saveStringData(key: 'email', data: googleUser.email ?? '');
        // await StorageService()
        //     .saveStringData(key: 'id', data: loginModule?.id ?? '');
        // await StorageService()
        //     .saveStringData(key: 'role', data: loginModule?.role ?? '');

        // String? role = await StorageService().getStringData('role');
        // String? id = await StorageService().getStringData('id');
        // log(role!);
        BotToast.closeAllLoading();

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            ProsteRouteAnimation(builder: (context) => const HomePage()),
            (route) => false,
          );
        }
        if (mounted) {
          setState(() {});
        }

        return;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: 'User not found');
        log('User not found');
        setState(() {});

        return;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      log(e.toString());
    }
  }
}
