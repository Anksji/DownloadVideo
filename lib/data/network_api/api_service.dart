import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloadandplayvideo/data/network_api/url.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    initialize();
  }

  Future<void> initialize() async{

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        responseType: ResponseType.json,
      ),
    );
    _dio.interceptors.add(LogInterceptor(request: true, requestBody: true));

  }

  Future<dynamic> fetchData(String endPoint,Map<String,dynamic>params) async {
    try{
      final response = await _dio.get(endPoint,queryParameters: params);
      return response;
    }on DioError catch(ex){
      debugPrint(ex.response?.data.toString());
      return ex.response?.data.toString();
    }
  }

  Future<bool> downloadVideo(
      {required String url,
      required String tempLocation,required int fileIndex,
      required upDateFileDownloadProgress}) async {
    try {
      Dio dio = Dio();
      Response response = await dio.download(
        url,
        tempLocation,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            double progress = (receivedBytes / totalBytes);
            upDateFileDownloadProgress(fileIndex,progress);
          }
        },
      );
      return true;
    } catch (error) {
      print('file status download error downloading video: $error');
      return false;
    }
  }

  Future<int> getFileSize(String fileUrl) async {
    try {

      final response = await _dio.head(fileUrl);

      if (response.statusCode == 200) {
        int contentLength = response.headers['content-length'] != null
            ? int.parse(response.headers['content-length']?[0] ?? '0')
            : 0;

        print('Total file size: $contentLength bytes');
        return contentLength;
      } else {
        print('Failed to get file size');
        return 0;
      }
    } catch (e) {
      print('Error: $e');
      return 0;
    }
  }


}

