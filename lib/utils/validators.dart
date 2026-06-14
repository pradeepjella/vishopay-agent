class Validators {
  static String? validateIndianMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter mobile number';
    }

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Enter valid Indian mobile number';
    }

    return null;
  }
}