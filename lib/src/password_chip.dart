
import 'package:flutter/material.dart';

class PasswordChip extends StatelessWidget {
  final bool isChecked;
  final String chipLabel;
  final TextStyle? checkedChipLabelStyle;
  final TextStyle? uncheckChipLabelStyle;
  final Color? uncheckChipColor;
  final Color? checkedChipColor;
  final Icon? checkIcon;
  const PasswordChip({Key? key, this.isChecked = false,
    required this.chipLabel, this.checkIcon,
    this.checkedChipLabelStyle,
    this.uncheckChipLabelStyle,
    this.uncheckChipColor, this.checkedChipColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(isChecked) Row(
            children: [
             checkIcon ??  Icon(
                Icons.check_outlined,
                size: 17,
                color: Colors.green.shade800,
              ),
              const SizedBox(width: 2,),
            ],
          ),
          Text(
            chipLabel,
          style: checkedChipLabelStyle ?? uncheckChipLabelStyle,)
        ],
      ),
      decoration: BoxDecoration(
          color: isChecked ? checkedChipColor ?? Colors.greenAccent.withOpacity(0.38) : uncheckChipColor ?? Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
