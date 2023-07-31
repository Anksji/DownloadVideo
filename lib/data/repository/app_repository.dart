import 'package:downloadandplayvideo/data/repository/video_files/video_files_repository_impl.dart';

class AppRepository{

  static final videoRepository=VideoFileRepositoryImpl();

  static final AppRepository _instance = AppRepository._internal();

  factory AppRepository(){
    return _instance;
  }
  AppRepository._internal();

}