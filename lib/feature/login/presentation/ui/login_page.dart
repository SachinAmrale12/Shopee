import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopee/common/utils/analytics.dart';
import 'package:shopee/main.dart';
import '../../../../common/colors/colors.dart';
import '../../../../common/utils/authentication.dart';
import '../../../../common/utils/custom_dialog.dart';
import 'google_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  var snackBar = const SnackBar(
    content: Text('Please enter valid email address or password'),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'LoginPage',
      screenClassOverride: 'LoginPage',
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (value!.isNotEmpty && !regex.hasMatch(value)) {
      _isEmailValid = false;
      return 'Enter a valid email address';
    } else {
      _isEmailValid = true;
      return null;
    }
  }

  String? isValidPassword(String? value) {
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final regex = RegExp(pattern);
    if (value!.isNotEmpty && !regex.hasMatch(value)) {
      _isPasswordValid = false;
      return 'Enter a valid password';
    } else {
      _isPasswordValid = true;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Shopee',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Login to your account using email',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: Column(
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: validateEmail,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: isValidPassword,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -25,
                    child: SizedBox(
                      width: 200,
                      height: 45,
                      child: FilledButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(buttonColor)),
                        onPressed: () {
                          Analytics.logEvent('login_button_clicked', null);
                          if (_isPasswordValid && _isEmailValid) {
                            Navigator.of(context).pushNamed('home');
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
              child: FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return const GoogleSignInButton();
                  }
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
