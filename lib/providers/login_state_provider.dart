import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrimpapp/constants.dart';
import 'package:shrimpapp/models/Account.dart';

class LoginStorageProvider {
  static Future<Account> loadFromSP() async {
    Account account;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('accountId');
    if (id == null) return null;
    try {
      Response res = await Dio(BaseOptions(connectTimeout: 3000))
          .get('$kServerApiUrl/accounts/$id');
      if (res.statusCode == 200) {
        account = Account.fromJson(res.data['data'][0]);
        account.token = prefs.getString('token');
        return account;
      }

      throw "Không tìm thấy thông tin người dùng, đăng nhập tự động thất bại";
    } on DioError catch (e) {
      print("Logged in local load failure: $e");
      if (e.type == DioErrorType.CONNECT_TIMEOUT) throw "Kiểm tra kết nối mạng";
      if (e.type == DioErrorType.DEFAULT) {
        throw "Kiểm tra kết nối mạng";
      }
      return null;
    } catch (e) {
      print(e);
      throw "Không tìm thấy thông tin người dùng, đăng nhập tự động thất bại";
    }
  }
}
