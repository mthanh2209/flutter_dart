import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/custom_app_bar.dart';
import '../components/search_box.dart';
import '../resources/app_color.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: CustomAppBar(
          leftPressed: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          title: widget.title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0)
            .copyWith(top: 12.0, bottom: 92.0),
        child: Column(
          children: [
            SearchBox(controller: _searchController),
            const Divider(height: 32.6, thickness: 1.36, color: AppColor.grey),
          ],
        ),
      ),
    );
  }
}
