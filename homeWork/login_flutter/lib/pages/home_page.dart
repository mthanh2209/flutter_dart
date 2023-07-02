import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import 'foodie_page.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 68, 121),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                const snackBar =
                    SnackBar(content: Text('Hello! I\'m a menu! 😍'));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Icon(Icons.menu, color: Colors.white),
            ),
            Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(Icons.menu, color: Colors.transparent),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 26.0),
                  const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.black, fontSize: 32.0),
                  ),
                  const SizedBox(height: 26.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                      controller: usernameController,
                      hintText: 'User Name',
                      icon: Icons.accessibility,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      icon: Icons.ac_unit,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 46.0),
                  Row(
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          onPressed: () {
                            String username = usernameController.text.trim();

                            String password = passwordController.text.trim();

                            String notification =
                                (username == '') || (password == '')
                                    ? 'Please input username and password! 😍'
                                    : 'Login successfully with $username! 😍';

                            final snackBar =
                                SnackBar(content: Text(notification));

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
          const Positioned(
            left: 14.6,
            bottom: 12.6,
            child: Text('Previous', style: TextStyle(color: Colors.blue)),
          ),
          Row(
            children: [
// const Expanded(flex: 2, child: SizedBox()),

              const Spacer(flex: 2),

              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(
                      builder: (context) =>
                          const FoodiePage(title: 'Foodie App'),
                    );

                    Navigator.push(context, route);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.yellow),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
