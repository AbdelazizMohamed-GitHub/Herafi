import 'package:flutter/widgets.dart';

class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({
    super.key,
    required this.buttonText,
    required this.buttonTextStyle,
    required this.buttonColor,
    required this.buttonIcon,
  });
  final String buttonText;
  final TextStyle buttonTextStyle;
  final Color buttonColor;
  final Widget buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: buttonColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          buttonIcon,
          SizedBox(width: 5),
          Text(buttonText, style: buttonTextStyle),
        ],
      ),
    );
  }
}
