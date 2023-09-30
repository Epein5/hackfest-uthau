import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/authorization/emailpasswordauth.dart';
import 'package:flutter_application_1/services/provider/NightMode.dart';
// import 'package:flutter_application_1/serivces/authorization/googleauth.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_application_1/resources/components/boxes.dart';
import 'package:provider/provider.dart';

class SIgnupView extends StatefulWidget {
  const SIgnupView({super.key});

  @override
  State<SIgnupView> createState() => _SIgnupViewState();
}

class _SIgnupViewState extends State<SIgnupView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontoller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    final providder = Provider.of<LoadingProvider>(context, listen: false);
    // GoogleAuth googleAuth = GoogleAuth();
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: height * 0.35,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(225, 0, 187, 134),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(80))),
                ),
                Positioned(
                    child: Image.asset(
                  'assets/Loggo.png',
                  scale: 2,
                ))
              ],
            ),
            SizedBox(
              height: height * 0.08,
            ),
            TestFieldNoProvider(
              icon: Icons.email,
              text: "Email",
              controller: emailcontoller,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            CostumTextField(
              icon: Icons.key,
              text: "Password",
              controller: passwordcontroller,
            ),
            SizedBox(
              height: height * 0.065,
            ),
            RoundButton(
              ontap: () {
                providder.setLoading(true);
                EmailPasswordAuthServices _authservice =
                    EmailPasswordAuthServices();
                _authservice.signup(
                    context,
                    emailcontoller.text.trim(),
                    // 'asdfghjkl@gmail.com',
                    // 'asdfghjkl'
                    passwordcontroller.text);
                // print(emailcontoller.text.trim() + '1');
              },
              text: "Register",
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  color: Colors.grey.shade900,
                  thickness: 1,
                )),
                Text(
                  "  Or continue with  ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.grey.shade900,
                  thickness: 1,
                )),
              ]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                // googleAuth.signInWithGoogle(context);
              },
              child: Container(
                height: height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.1),
                        spreadRadius: 7,
                        blurRadius: 5,
                        offset:
                            const Offset(3, 6), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/googleicon.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have a account ? ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.loginview);
                  },
                  child: const Text(
                    'Login Now ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(225, 0, 187, 134),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
