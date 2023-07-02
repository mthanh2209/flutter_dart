import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class FoodItem extends StatelessWidget {
  final VoidCallback? onPressed; //diễn tả 1 sự kiện
  final FoodModel food;
  const FoodItem({
    super.key,
    this.onPressed,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 12.0;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade600,
              offset: const Offset(0.0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.asset(food.imageStr ?? '',
                  width: 90.0, fit: BoxFit.contain),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    food.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    food.description ?? '',
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    children: [
                      Text(
                        (food.price ?? 0.0).toStringAsFixed(2),
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const Text(
                        '\$',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        'x${food.quantity ?? 0}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
          ],
        ),
      ),
    );
  }
}
