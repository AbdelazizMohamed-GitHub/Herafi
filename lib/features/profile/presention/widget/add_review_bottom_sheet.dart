import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_cubit.dart';

class AddReviewBottomSheet extends StatefulWidget {
  const AddReviewBottomSheet({super.key, required this.herafiId});

  final String herafiId;

  @override
  State<AddReviewBottomSheet> createState() => _AddReviewBottomSheetState();
}

class _AddReviewBottomSheetState extends State<AddReviewBottomSheet> {
  final _commentController = TextEditingController();
  int _rating = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_rating == 0) {
      CustomSnackBarWidget.show(
        context,
        message: 'اختر عدد النجوم أولًا',
        type: SnackBarType.warning,
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      context.go(HerafiRoutes.signIn);
      return;
    }

    setState(() => _isSubmitting = true);
    final userName = user.displayName?.trim();
    final result = await context.read<ProfileCubit>().addReview(
      herafiId: widget.herafiId,
      userId: user.uid,
      userName: userName == null || userName.isEmpty ? 'مستخدم' : userName,
      rating: _rating,
      comment: _commentController.text.trim(),
    );

    if (!mounted) return;

    setState(() => _isSubmitting = false);
    result.fold(
      (failure) => CustomSnackBarWidget.show(
        context,
        message: failure.message,
        type: SnackBarType.error,
      ),
      (_) {
        CustomSnackBarWidget.show(
          context,
          message: 'تم إرسال تقييمك بنجاح',
          type: SnackBarType.success,
        );
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, bottomInset + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('أضف تقييمك', style: HerafiStyles.text20Black),
            const SizedBox(height: 16),
            const Text('اختر عدد النجوم'),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final value = index + 1;
                  return IconButton(
                    onPressed: _isSubmitting
                        ? null
                        : () => setState(() => _rating = value),
                    icon: Icon(
                      value <= _rating ? Icons.star : Icons.star_border,
                      color: HerafiColors.goldColor,
                      size: 36,
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              enabled: !_isSubmitting,
              maxLines: 3,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(
                labelText: 'تعليقك (اختياري)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HerafiColors.goldColor,
                  foregroundColor: Colors.white,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('إرسال التقييم'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
