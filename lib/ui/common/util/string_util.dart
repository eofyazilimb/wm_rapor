class StringUtil {
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static String toUpperCaseString(String value) {
    if (value.isEmpty) return value;
    return value.toUpperCase();
  }

  static bool inputEmptyValueCheck(String value) {
    if (value.isNotEmpty && value != "" && value != ',' && value != '.') {
      return true;
    } else {
      return false;
    }
  }

  static String limitedText(String value, int maxLength) {
    String limitedText = value.length > maxLength
        ? '${value.substring(0, maxLength)}...'
        : value;
    return limitedText;
  }

  static String currencySymbol(String currency) {
    switch (currency) {
      case 'TRY':
        return '₺';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      default:
        return '';
    }
  }
}
