import 'package:downloadandplayvideo/data/models/video_model.dart';

abstract class VideoFilesRepository{

  Future<List<VideoModel>> fetchVideoList();

  Future<String> downloadVideo({required String downloadUrl,required String fileLocalPath,
  required int fileIndex,required Function(int fileIndex,double progress) upDateFileDownloadProgress});

}