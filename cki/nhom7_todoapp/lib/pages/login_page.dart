import 'package:flutter/material.dart';
import 'package:nhom7_todoapp/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/custom_bottom.dart';
import '../components/custom_text_field.dart';
import 'forgot_pass.dart';
import 'home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRegistered = false; //mặc định chưa đki

  @override
  void initState() {
    super.initState();
    checkIfRegistered();
  }

  void checkIfRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (username != null && password != null) {
      setState(() {
        isRegistered = true;
      });
    }
  }

  void saveRegistrationCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    setState(() {
      isRegistered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('LOGIN'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Login_1.png"),
                fit: BoxFit.fitWidth)),
        padding: const EdgeInsets.only(top: 26.0),
        child: Column(
          children: [
            const Icon(
              Icons.auto_stories_outlined,
              size: 50.0,
              color: Color.fromARGB(255, 244, 245, 247),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                controller: usernameController,
                hintText: 'Username',
                icon: Icons.people_rounded,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                icon: Icons.password_rounded,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text.trim();
                String password = passwordController.text.trim();
                if (username.isNotEmpty && password.isNotEmpty) {
                  validateCredentials(username, password);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Invalid Credentials'),
                        content: const Text('Please enter username and password.'),
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
              child: const CustomButton(text: 'Login', width: 200),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              height: 20.6,
            ),
            if (!isRegistered)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegisterPage(
                        onRegistered: saveRegistrationCredentials,
                      ),
                    ),
                  );
                },
                child: const Text('Register'),
              ),
            if (isRegistered)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ForgotPage(),
                        ),
                      );
                    },
                    child: const Text('Forgot Password'),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  void validateCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    String? storedPassword = prefs.getString('password');

    if (storedUsername != null && storedPassword != null) {
      if (username == storedUsername && password == storedPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(title: 'todo'),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Credentials'),
              content: Text('Incorrect username or password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('No registered user found.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } ;
  }
}
