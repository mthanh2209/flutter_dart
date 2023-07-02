import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  final double diemVan;
  final double diemAnh;

  const InformationPage({
    super.key,
    required this.diemVan,
    required this.diemAnh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Điểm Văn: ${diemVan.toStringAsFixed(2)}'),
            Text('Điểm Anh: ${diemAnh.toStringAsFixed(2)}'),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
