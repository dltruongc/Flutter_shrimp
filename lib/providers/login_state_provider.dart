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
      Response res = await Dio(BaseOptions(connectTimeout: 5000)).post(
        '$kServerApiUrl/accounts/check/$id',
        options: new Options(
          contentType: "application/x-www-form-urlencoded",
          headers: {
            'charset': 'utf-8',
            'Authorization': 'Bearer ' + prefs.getString('token'),
          },
        ),
      );

      if (res.statusCode == 200) {
        account = Account.fromJson(res.data['data'][0]);
        account.token = prefs.getString('token');
        return account;
      }
      throw "Không tìm thấy thông tin người dùng, đăng nhập tự động thất bại";
    } on DioError catch (e) {
      print(e.error);

      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.response.statusCode == 404)
        throw "Kiểm tra kết nối mạng";
      else if (e.type == DioErrorType.RESPONSE) {
        throw e.response.data['message'];
      } else
        throw "Kiểm tra kết nối mạng";
    } catch (e) {
      print(e);
      throw "Không tìm thấy thông tin người dùng, đăng nhập tự động thất bại";
    }
  }
}
