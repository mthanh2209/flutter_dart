import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/authen.dart';
import 'forgot_page.dart';
import 'register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 26.0),
                  const Text(
                    'Login',
                    style: TextStyle(color: Colors.blue, fontSize: 32.0),
                  ),
                  const SizedBox(height: 26.0),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Username',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                      controller: usernameController,
                      hintText: 'Enter Username',
                      icon: Icons.accessibility,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                      controller: passwordController,
                      hintText: 'Enter password',
                      icon: Icons.ac_unit,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 46.0),
                  Row(
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          onPressed: () {
                            String username = usernameController.text.trim();
                            String password = passwordController.text.trim();
                            if (username == Authen.username &&
                                password == Authen.password) {
                              final snackBar =
                                  SnackBar(content: Text('Login success!'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(
                                  content:
                                      Text('Invalid username or password!'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          text: 'Login',
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                  const SizedBox(height: 16.4),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ForgotPage()));
                  },
                  child: const Text(
                    'Forgot Password?|',
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.grey),
                  ),
                ),
                //style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
