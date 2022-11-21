
import 'package:flutter/material.dart';

class PasswordChip extends StatelessWidget {
  final bool isChecked;
  final String label;
  const PasswordChip({Key? key, this.isChecked = false, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(isChecked) Row(
            children: [
              Icon(
                Icons.check_outlined,
                size: 17,
                color: Colors.green.shade800,
              ),
              const SizedBox(width: 2,),
            ],
          ),
          Text(label,)
        ],
      ),
      decoration: BoxDecoration(
          color: isChecked ? Colors.greenAccent.withOpacity(0.38) : Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
