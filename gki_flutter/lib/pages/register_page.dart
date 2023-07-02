import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                    'Register',
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
                      'New password',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                      controller: passwordController,
                      hintText: 'Enter new password',
                      icon: Icons.ac_unit,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 26.0),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Confirm password',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                      controller: confirmPasswordController,
                      hintText: 'Enter confirm password',
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
                            String confirmPassword =
                                confirmPasswordController.text.trim();
                            String notification = (username == '') ||
                                    (password == '') ||
                                    (confirmPassword == '')
                                ? 'Please input username and password'
                                : 'Register successfully with $username';
                            final snackBar =
                                SnackBar(content: Text(notification));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Route route = MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            );
                            Navigator.push(context, route);
                          },
                          text: 'Next',
                        ),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
