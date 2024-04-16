// ignore_for_file: non_constant_identifier_names

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

  static Future<Either<Failure,Map>> storeService(
    String no_plat, String mobil, String pemilik, String no_pemilik, DateTime tanggal, String jasa, String barang
  ) async {
    Uri url = Uri.parse('${AppConstant.baseURL}/service/post');
    try {
      final response = await http.post(
        url,
        body: {
          'no_plat' : no_plat,
          'mobil' : mobil,
          'pemilik' : pemilik,
          'no_pemilik' : no_pemilik,
          'tanggal' : tanggal,
          'jasa' : jasa,
          'barang' : barang
        }
      );
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
