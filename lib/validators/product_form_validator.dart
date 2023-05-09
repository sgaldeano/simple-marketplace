

class ProductFormValidator {

  static String? validateMandatoryText(String? value, String message) {
    return value != null && value.isNotEmpty
      ? null
      : message;
  }

  static String? validateMandatoryNumber(String? value, String message) {
    return value != null && value.isNotEmpty && double.tryParse(value) != null && double.parse(value) >= 0
      ? null
      : message;
  }

}