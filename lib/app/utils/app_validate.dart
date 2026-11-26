class AppValidate {
  static String? name(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return 'الرجاء إدخال الاسم';
    }
    if (name.length < 3) {
      return 'يجب أن يحتوي الاسم على 3 أحرف على الأقل';
    }
    return null;
  }

  static String? phone(String? value) {
    final phone = value?.trim().replaceAll(' ', '') ?? '';
    if (phone.isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }

    final normalizedPhone = phone.startsWith('+20')
        ? '0${phone.substring(3)}'
        : phone;
    if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(normalizedPhone)) {
      return 'أدخل رقم هاتف مصرّي صحيح';
    }
    return null;
  }

  static String? location(String? value) {
    final location = value?.trim() ?? '';
    if (location.isEmpty) {
      return 'الرجاء إدخال الموقع';
    }
    if (location.length < 3) {
      return 'يجب أن يحتوي الموقع على 3 أحرف على الأقل';
    }
    return null;
  }

  static String? job(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء اختيار الحرفة';
    }
    return null;
  }
}
