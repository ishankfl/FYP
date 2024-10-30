class ValidationTextField {
  static String? validateField(String value, String fieldName) {
    bool isValidEmail(String email) {
      final emailRegex =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      return emailRegex.hasMatch(email);
    }

    // Additional function for email validation
    bool isValidPhonumber(String email) {
      int? phoneNumber;
      try {
        phoneNumber = int.parse(email);
        return true;
      } catch (e) {
        return false;
      }
    }

    bool isValidName(String name) {
      int? fullname;
      try {
        fullname = int.parse(name);
        return false;
      } catch (e) {
        return true;
      }
    }

    if (value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    if (fieldName == 'Fullname' && !isValidName(value)) {
      return 'Please enter a valid Name';
    }
    if (fieldName == 'Email' && !isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    if (fieldName == 'Phonenumber' && !isValidPhonumber(value)) {
      return 'Please enter a valid phonenumber';
    }
    if (fieldName == 'Phonenumber' && value.length < 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }
}
