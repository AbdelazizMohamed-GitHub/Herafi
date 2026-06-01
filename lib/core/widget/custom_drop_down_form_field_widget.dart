// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:herafi_app/core/constant/herfa_list.dart';

class CustomDropdownFormField extends StatefulWidget {
  const CustomDropdownFormField({super.key});

  @override
  State<CustomDropdownFormField> createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  late String? selectedHerafa;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      //  initialValue: widget.isUpdate ? widget.productCategory : selectedCategory,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "اختر حرفتك",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: herfaList.map((harfa) {
        return DropdownMenuItem<String>(
          value: harfa.herfaName,
          child: Text(harfa.herfaName),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedHerafa = value;
        });
      },
    );
  }
}
