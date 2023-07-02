import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../resources/app_color.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback? leftPressed;
  final String title;
  const CustomAppBar({super.key, this.leftPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0)
          .copyWith(top: MediaQuery.of(context).padding.top + 4.6, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftPressed,
            child: Transform.rotate(
              angle: 45 * (math.pi / 180),
              child: Container(
                padding: const EdgeInsets.all(6.8),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.shadow,
                      offset: Offset(3.0, 3.0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Transform.rotate(
                  angle: -45 * (math.pi / 180),
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 24.0, color: AppColor.brown),
                ),
              ),
            ),
          ),
          Text(title,
              style: const TextStyle(color: AppColor.blue, fontSize: 22.0)),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
            radius: 24.0,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(64.0);
}
