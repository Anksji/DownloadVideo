import 'dart:async';
import 'package:downloadandplayvideo/business_logic/bloc/video_bloc/video_events.dart';
import 'package:downloadandplayvideo/business_logic/bloc/video_bloc/video_state.dart';
import 'package:downloadandplayvideo/data/models/video_model.dart';
import 'package:downloadandplayvideo/data/repository/app_repository.dart';
import 'package:downloadandplayvideo/data/repository/video_files/video_files_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class VideoBloc extends Bloc<VideoEvents,VideoState>{

  final VideoFilesRepository _videoRepository = AppRepository.videoRepository;
  VideoBloc(): super(const IdealState());
  List<VideoModel> videoFiles = [];


  @override
  Stream<VideoState> mapEventToState(VideoEvents event) async* {

    if(event is FetchVideos){
      yield* _mapLoadVideos(event);
    }else if(event is DownloadVideoFile){
      yield* _mapDownloadVideo(event);
    }
  }

  Stream<VideoState> _mapDownloadVideo(DownloadVideoFile event) async*{
    try{
      videoFiles[event.fileIndex].fileDownloadProgress.value=0.01;
      yield VideoFileDownloading(file: event.file, fileIndex: event.fileIndex);
      yield VideoListUpdateState(videoList: videoFiles);
      String fileName=await _videoRepository.downloadVideo(
          downloadUrl:event.file.sources![0],fileLocalPath:event.localfileName,
          fileIndex:event.fileIndex,upDateFileDownloadProgress : upDateFileDownloadProgress);
      if(fileName.isNotEmpty){
        print("file download success");
      }else{

        print("file download falied");
      }
      videoFiles[event.fileIndex].fileDownloadProgress.value=1.0;
      videoFiles[event.fileIndex].isFileDownloaded=true;
      videoFiles[event.fileIndex].fileLocalPath=fileName;
      yield VideoListUpdateState(videoList: videoFiles);
    } catch(e){
      yield VideoFetchErrorState(error: e.toString());
    }
  }

  upDateFileDownloadProgress(int fileIndex, double progress){
    videoFiles[fileIndex].fileDownloadProgress.value=progress;
  }

  Stream<VideoState> _mapLoadVideos(FetchVideos event) async*{
    try{
      yield const VideoLoadingProgress();
      videoFiles=await _videoRepository.fetchVideoList();
      yield VideoFetchedState(videoList: videoFiles);

    } catch(e){
      yield VideoFetchErrorState(error: e.toString());
    }
  }



}

