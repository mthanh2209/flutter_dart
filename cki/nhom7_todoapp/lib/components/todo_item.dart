import 'package:flutter/material.dart';

import '../resource/app_color.dart';
class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    this.onTap,
    this.onDeleted,
    required this.text,
    required this.isDone,

    //
    this.onRestored,
    

  });

  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final String text;
  final bool isDone;

  //
   final VoidCallback? onRestored;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.6)
            .copyWith(left: 14.0, right: 8.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadow,
              offset: Offset(0.0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              () {
                if (isDone) {
                  return Icons.check_box_rounded;
                }
                return Icons.check_box_outline_blank;
              }(),
              size: 16.8,
              color: Color.fromARGB(255, 143, 136, 255),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.6, right: 4.6),
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: isDone
                        ? TextDecoration.none
                        : TextDecoration.none,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            //
            InkWell(
              onTap: onRestored, // Call onRestored callback when tapped
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 28, 222, 151),
                radius: 12.0,
                child: Icon(Icons.restore, size: 14.0, color: AppColor.white),
              ),
             ),
            ),
            //
            InkWell(
              onTap: onDeleted,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 234, 65, 79),
                  radius: 12.0,
                  child: Icon(Icons.delete, size: 14.0, color: AppColor.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

