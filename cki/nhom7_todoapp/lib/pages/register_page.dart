import 'package:flutter/material.dart';

import '../components/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function(String username, String password) onRegistered;

  const RegisterPage({Key? key, required this.onRegistered}) : super(key: key);

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
      appBar: AppBar(
        title: const Text('REGISTER'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Register_1.png"),
                fit: BoxFit.fitWidth)),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.app_registration,
              size: 50,
              color: Color.fromARGB(255, 245, 248, 251),
            ),
            const SizedBox(
              height: 26.0,
            ),
            CustomTextField(
              controller: usernameController,
              hintText: 'User name',
              icon: Icons.people_rounded,
            ),
            const SizedBox(height: 20.0),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              icon: Icons.password_rounded,
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              icon: Icons.password_rounded,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text.trim();
                String password = passwordController.text.trim();
                String confirmPassword = confirmPasswordController.text.trim();

                if (username.isNotEmpty &&
                    password.isNotEmpty &&
                    confirmPassword.isNotEmpty) {
                  if (password == confirmPassword) {
                    widget.onRegistered(username, password);
                    Navigator.pop(context);
                  } else {
                    // Hiển thị thông báo lỗi nếu mật khẩu xác nhận không khớp
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Invalid Password'),
                          content: const Text(
                              'Password and Confirm Password do not match.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // Hiển thị thông báo lỗi nếu một trường thông tin bị bỏ trống
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Invalid Information'),
                        content: const Text(
                            'Please enter all required information.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
