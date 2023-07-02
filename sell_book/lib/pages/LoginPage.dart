import 'package:flutter/material.dart';
import 'package:sell_book/component/CustomButton.dart';
import 'package:sell_book/component/Custom_textfile.dart';
import 'package:sell_book/pages/RegisterPage.dart';
import 'package:sell_book/pages/TabItemPage.dart';
import 'package:sell_book/pages/forgotPass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRegistered = false; //chưa đki

  @override
  void initState() {
    super.initState();
    checkIfRegistered();
  }

  void checkIfRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs
        .getString('username'); //để lấy giá trị từ bộ nhớ SharedPreferences
    String? password = prefs.getString('password');

    if (username != null && password != null) {
      setState(() {
        isRegistered = true;
      });
    }
  }

  void saveRegistrationCredentials(String username, String password) async {
    //lưu trữ thông tin đăng ký của người dùng
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'username', username); //lưu trữ user và pass vào SharedPreferences
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
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/BG-g7.png"),
                fit: BoxFit.fitWidth)),
        padding: const EdgeInsets.only(top: 26.0),
        child: Column(
          children: [
            const Icon(
              Icons.mobile_friendly_outlined,
              size: 50.0,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                controller: usernameController,
                hintText: 'User name',
                icon: Icons.supervised_user_circle,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                controller: passwordController,
                hintText: 'PassWord',
                icon: Icons.password,
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
            const SizedBox(height: 50),
            const Divider(
              color: Colors.red,
            ),
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
                          builder: (BuildContext context) => const ForgotPage(),
                        ),
                      );
                    },
                    child: const Text('Forgot  Password'),
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
            builder: (BuildContext context) => TabItemPage(),
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
    }
  }
}
