import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/authorization/emailpasswordauth.dart';
// import 'package:flutter_application_1/serivces/authorization/googleauth.dart';
import 'package:flutter_application_1/services/provider/NightMode.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';
import 'package:flutter_application_1/resources/components/boxes.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailcontoller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController resetpasswordcontroller = TextEditingController();
  EmailPasswordAuthServices _authservice = EmailPasswordAuthServices();
  // GoogleAuth googleAuth = GoogleAuth();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontoller.dispose();
    passwordcontroller.dispose();
    resetpasswordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providder = Provider.of<LoadingProvider>(context, listen: false);

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

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
                Positioned(child: Image.asset('assets/Loggo.png', scale: 2))
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: PopupMenuButton(
                  offset: const Offset(0, -380),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: SizedBox(
                      height: height * 0.9,
                      width: width * 0.9,
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.35,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(225, 0, 187, 134),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(80))),
                              ),
                              Positioned(
                                  child: Image.asset(
                                'assets/Loggo.png',
                                scale: 13,
                              ))
                            ],
                          ),
                          TextFormField(
                            controller: resetpasswordcontroller,
                            decoration:
                                const InputDecoration(hintText: 'Email'),
                          ),
                          SizedBox(
                            height: height * .05,
                          ),
                          RoundButton(
                              text: 'Reset Password',
                              ontap: () {
                                // _authservice.forgotpassword(context,
                                //     resetpasswordcontroller.text.trim());
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    ))
                  ],
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            RoundButton(
              ontap: () async {
                providder.setLoading(true);
                await _authservice.login(context,
                // 'asdfghjkl@gmail.com',
                // 'asdfghjkl'
                emailcontoller.text.trim(),
                    passwordcontroller.text
                    
                    );
              },
              text: "Login",
            ),
            SizedBox(
              height: height * 0.03,
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
                        color: const Color.fromARGB(225, 0, 187, 134)
                            .withOpacity(0.1),
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
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have a account ? ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signupview);
                  },
                  child: const Text(
                    'Register Now ',
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
