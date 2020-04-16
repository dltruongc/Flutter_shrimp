class InputValidate {
  static bool isValidUserName(String username) {
    Pattern pattern = r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{5,29}$';
    RegExp regex = RegExp(pattern, caseSensitive: false);
    return regex.hasMatch(username);
  }

  static bool isValidPassword(String password) {
    Pattern pattern = r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{5,29}$';
    RegExp regex = RegExp(pattern, caseSensitive: true);
    return regex.hasMatch(password);
  }

  static bool isValidName(String name) {
    name = name.trim();
    return (name.length > 0 && name != null && name.contains(" "));
  }

  static bool isValidAddress(String address) {
    return true;
  }

  static bool isValidPhone(String phone) {
    if (phone.contains('.')) return false;
    try {
      num.parse(phone);
    } catch (e) {
      return false;
    }
    return phone.length == 10;
  }

  static bool isValidEmail(String email) {
    Pattern pattern =
        r'^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$';
    RegExp regex = RegExp(pattern, caseSensitive: false);
    return regex.hasMatch(email);
  }

  static bool isValidWebsite(String website) {
    Pattern pattern =
        r'^(https?:\/\/)?([\w\d-_]+)\.([\w\d-_\.]+)\/?\??([^#\n\r]*)?#?([^\n\r]*)';
    RegExp regex = RegExp(pattern, caseSensitive: false);
    return regex.hasMatch(website);
  }

  static bool isValidCity(String city) {
    city = city.trim();
    return (city.length > 0 && city != null);
  }
}
