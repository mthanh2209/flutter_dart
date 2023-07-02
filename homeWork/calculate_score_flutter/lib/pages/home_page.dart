import 'package:flutter/material.dart';
import 'information_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController vanController = TextEditingController();

  TextEditingController anhController = TextEditingController();

  String diemTB = 'Điểm TB';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'ABC',
            style: TextStyle(color: Colors.yellow),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            TextField(
              controller: vanController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                hintText: 'Nhập Điểm Văn',
                labelText: 'Điểm Văn',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: anhController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                hintText: 'Nhập Điểm Anh',
                labelText: 'Điểm Anh',
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Spacer(),
                Text(diemTB),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    double diemVan = double.parse(vanController.text.trim());

                    double diemAnh = double.parse(anhController.text.trim());

                    diemTB = ((diemVan + diemAnh) / 2).toStringAsFixed(2);

                    setState(() {});
                  },
                  child: const Text(
                    'Calculate',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
// const Expanded(flex: 2, child: SizedBox()),

                const Spacer(flex: 2),

                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      double diemVan = double.parse(vanController.text.trim());

                      double diemAnh = double.parse(anhController.text.trim());

                      Route route = MaterialPageRoute(
                        builder: (context) =>
                            InformationPage(diemVan: diemVan, diemAnh: diemAnh),
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
      ),
    );
  }
}
