import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import 'home_page.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();
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
                    'Forgot Password',
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
                      controller: newPasswordController,
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
                      controller: resetPasswordController,
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
                            String newPassword =
                                newPasswordController.text.trim();
                            String resetPassword =
                                resetPasswordController.text.trim();
                            String notification = (username == '') ||
                                    (newPassword == '') ||
                                    (resetPassword == '')
                                ? 'Please input username and password'
                                : 'Reset password successfully with $username';
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
