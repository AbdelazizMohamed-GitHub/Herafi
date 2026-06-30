String formatEgyptPhone(String phone) {
  phone = phone.trim();

  // remove spaces
  phone = phone.replaceAll(' ', '');

  if (phone.startsWith('+')) {
    return phone; // already E.164
  }

  if (phone.startsWith('0')) {
    phone = phone.substring(1);
  }

  return '+20$phone';
}

final phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
