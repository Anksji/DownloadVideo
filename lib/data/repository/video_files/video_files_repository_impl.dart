import 'dart:convert';
import 'package:downloadandplayvideo/data/models/video_model.dart';
import '../../network_api/api_service.dart';
import '../../network_api/end_points.dart';
import 'video_files_repository.dart';


class VideoFileRepositoryImpl implements VideoFilesRepository{

  final ApiService _apiService=ApiService();

  static final VideoFileRepositoryImpl _instance = VideoFileRepositoryImpl._internal();

  factory VideoFileRepositoryImpl(){
    return _instance;
  }

  VideoFileRepositoryImpl._internal();

  @override
  Future<List<VideoModel>> fetchVideoList() async {
    List<VideoModel> files=[];
    try{

      print("current response data is");
      Map<String, String> params = {};

      params['id']='1FEOTw_ioZ4SR4Iq5UxqsqcEgKAg3bNtX';

      var res = await _apiService.fetchData(videosEndPoint, params);
      Map<String, dynamic> jsonMap = json.decode(res.toString());
      List<dynamic> categories = jsonMap['categories'];
      for (var category in categories) {
        List<dynamic> videos = category['videos'];
        for (var video in videos) {
          VideoModel file=VideoModel.fromJson(video);
          file.fileTotalSize=await _apiService.getFileSize(file.sources?[0]??'');
          print('file total size ${file.fileTotalSize}');
          files.add(file);
        }
      }
      return files;
    } catch(error){
      print("error ${error}");
    }

    return files;
  }

  @override
  Future<String> downloadVideo(
      {required String downloadUrl,required String fileLocalPath,
        required int fileIndex,
        required Function upDateFileDownloadProgress}) async {
    try{
      bool  isSuccess = await _apiService.downloadVideo(url: downloadUrl, tempLocation: fileLocalPath, fileIndex: fileIndex,
          upDateFileDownloadProgress: upDateFileDownloadProgress);

      if(isSuccess){
        return fileLocalPath;
      }else{
        return '';
      }
    } catch(error){
      print("error ${error}");
      return '';
    }
  }
}