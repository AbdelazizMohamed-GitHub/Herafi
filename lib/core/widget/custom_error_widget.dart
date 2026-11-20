import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });
  final String errorMessage;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 50, color: Colors.red),
        SizedBox(height: 10),
        Text(errorMessage, style: TextStyle(fontSize: 18, color: Colors.red)),
        SizedBox(height: 20),
        ElevatedButton(onPressed: onRetry, child: Text('إعادة المحاولة')),
      ],
    );
  }
}
