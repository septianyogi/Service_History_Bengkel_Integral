import 'package:bengkel_service/config/app_constant.dart';
import 'package:bengkel_service/config/app_response.dart';
import 'package:bengkel_service/config/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class ServiceDataSource {
  static Future<Either<Failure, Map>> searchPlat(String plat) async {
    Uri url = Uri.parse('${AppConstant.baseURL}/service/$plat');
    try {
      final response = await http.get(url);
      final data = AppResponse.data(response);
      return right(data);
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(FetchFailure(e.toString()));
    }
  }

  static Future<Either<Failure, Map>> service() async {
    Uri url = Uri.parse('${AppConstant.baseURL}/service');
    try {
      final response = await http.get(url);
      final data = AppResponse.data(response);
      return right(data);
    } catch (e) {
      if (e is Failure) {
        return left(e);
      }
      return left(FetchFailure(e.toString()));
    }
  }
}
