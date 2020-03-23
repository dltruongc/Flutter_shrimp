class InputValidate {
  static bool isValidUserName(String username) {
    if (username.length < 5 || username == null) {
      return false;
    } else
      return true;
  }

  static bool isValidPassword(String password) {
    if (password.length < 5) {
      return false;
    } else
      return true;
  }

  static bool isValidName(String name) {
    return (name.length > 0 && name != null && name.contains(" "));
  }

  static bool isValidAddress(String address) {
    return true;
  }

  static bool isValidPhone(String phone) {
    print(phone);
    print(phone.length);
    return phone.length == 10;
  }

  static bool isValidaddress(String address) {
    if (address.length < 6 || address == null) {
      return false;
    }
    return true;
  }
}
