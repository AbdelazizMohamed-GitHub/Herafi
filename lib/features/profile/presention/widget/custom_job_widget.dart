import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/core/widget/custom_drop_down_form_field_widget.dart';

class CustomJobWidget extends StatefulWidget {
  const CustomJobWidget({
    super.key,
    this.selectedJob1,
    this.selectedJob2,
    this.onJob1Changed,
    this.onJob2Changed,
  });

  final String? selectedJob1;
  final String? selectedJob2;

  final ValueChanged<String?>? onJob1Changed;
  final ValueChanged<String?>? onJob2Changed;

  @override
  State<CustomJobWidget> createState() => _CustomJobWidgetState();
}

class _CustomJobWidgetState extends State<CustomJobWidget> {
  bool showSecondJob = false;

  String? selectedJob1;
  String? selectedJob2;

  @override
  void initState() {
    super.initState();

    selectedJob1 = widget.selectedJob1;
    selectedJob2 = widget.selectedJob2;

    // لو فيه مهنة ثانية جاية من البيانات، أظهر الـ dropdown الثاني
    showSecondJob =
        widget.selectedJob2 != null && widget.selectedJob2!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          // المهنة الأولى
          Expanded(
            child: CustomDropdownFormField(
              initialValue: selectedJob1,
              onChanged: (value) {
                setState(() {
                  selectedJob1 = value;
                });

                widget.onJob1Changed?.call(value);
              },
            ),
          ),

          const SizedBox(width: 8),

          // زر إضافة مهنة
          if (!showSecondJob)
            IconButton(
              onPressed: () {
                setState(() {
                  showSecondJob = true;
                });
              },
              icon: const Icon(
                Icons.add_circle_outline,
                color: HerafiColors.goldColor,
                size: 30,
              ),
            ),

          // المهنة الثانية
          if (showSecondJob) ...[
            Expanded(
              child: CustomDropdownFormField(
                initialValue: selectedJob2,
                onChanged: (value) {
                  setState(() {
                    selectedJob2 = value;
                  });

                  widget.onJob2Changed?.call(value);
                },
              ),
            ),

            // زر حذف المهنة الثانية
            IconButton(
              onPressed: () {
                setState(() {
                  showSecondJob = false;
                  selectedJob2 = null;
                });

                widget.onJob2Changed?.call(null);
              },
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
                size: 30,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
