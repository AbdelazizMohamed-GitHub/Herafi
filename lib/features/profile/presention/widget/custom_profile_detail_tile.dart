import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';

class CustomProfileDetailTileWidget extends StatelessWidget {
  const CustomProfileDetailTileWidget({
    super.key,
    this.icon,

    required this.label,
    required this.value,
    required this.ontap,
  });

  final IconData? icon;
  final String label;
  final String value;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: IconButton(onPressed: ontap, icon: Icon(icon, size: 30)),
        contentPadding: const EdgeInsets.all(8),
        title: Text(label, style: HerafiStyles.text16GoldBold),
        subtitle: Text(value, style: HerafiStyles.text20Black),
      ),
    );
  }
}
