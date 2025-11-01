import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Networkservice extends GetxService {
  final dio = Dio();
  final loading = false.obs;

  Future<dynamic> getmock(String url) async {
    final response = await Future.delayed(
      Duration(seconds: 2),
      () => rootBundle.loadString('assets/mock/mockdata.json'),
    );
    if (response.isNotEmpty) {
      return response;
    }

    return null;
  }

  Future<void> post(String url, Map<String, dynamic> data) async {
    loading.value = true;
    try {
      var response = await dio.post(
        url,
        data: data,
        options: Options(headers: {}),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (e) {
      throw Exception({"post": false, "message": e.message});
    } on PlatformException catch (e) {
      throw Exception({"post": false, "message": e.message});
    } catch (e) {
      throw Exception({"post": false, "message": e.toString()});
    } finally {
      loading.value = false;
    }
  }
}
