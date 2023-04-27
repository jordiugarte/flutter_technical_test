class ValidatorsHelper {
  static String? isValidName(String? value) {
    if (value == null) {
      return "Enter a valid name";
    }
    if (!_isInsideRange(0, 128, value)) {
      return "Name must be less or equal than 128 characters";
    } else {
      return null;
    }
  }

  static String? isValidStreet(String? value) {
    if (value == null) {
      return "Enter a valid street";
    }
    if (!_isInsideRange(0, 128, value)) {
      return "Street must be less or equal than 128 characters";
    } else {
      return null;
    }
  }

  static String? isValidAdditional(String? value) {
    if (value == null) {
      return "Enter valid additional information";
    }
    if (!_isInsideRange(0, 256, value)) {
      return "Additional information must be less or equal than 256 characters";
    } else {
      return null;
    }
  }

  static String? isValidPostalCode(String? value) {
    if (value == null) {
      return "Enter a valid postal code";
    }
    if (!_isInsideRange(0, 5, value)) {
      return "Postal Code must be less or equal than 5 characters";
    } else {
      return null;
    }
  }

  static String? isValidMunicipality(String? value) {
    if (value == null) {
      return "Enter a valid municipality";
    }
    if (!_isInsideRange(0, 64, value)) {
      return "Municipality must be less or equal than 64 characters";
    } else {
      return null;
    }
  }

  static String? isValidNumber(String? value) {
    if (value == null) {
      return "Enter a valid number";
    } else {
      try {
        int.parse(value);
        return null;
      } catch (e) {
        return "Enter a valid number";
      }
    }
  }

  static bool _isInsideRange(int min, int max, String value) {
    return value.length > min && value.length <= max;
  }
}
