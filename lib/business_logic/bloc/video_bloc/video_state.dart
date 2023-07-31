import 'package:downloadandplayvideo/data/models/video_model.dart';
import 'package:equatable/equatable.dart';


abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoLoadingProgress extends VideoState{
      const VideoLoadingProgress();
}
class IdealState extends VideoState{
      const IdealState();
}

class VideoFetchedState extends VideoState {
  final List<VideoModel> videoList;
  VideoFetchedState({
    required this.videoList
  });

  @override
  List<Object?> get props => [videoList];
}

class VideoListUpdateState extends VideoState {
  final List<VideoModel> videoList;
  VideoListUpdateState({
    required this.videoList
  });

  @override
  List<Object?> get props => [videoList];
}


class VideoFileDownloading extends VideoState {
  final VideoModel file;
  final int fileIndex;
  VideoFileDownloading({required this.file,required this.fileIndex});

  @override
  List<Object?> get props => [file];
}

class VideoDownloaded extends VideoState {
  final VideoModel file;
  final String fileName;
  final int fileIndex;
  VideoDownloaded({required this.file, required this.fileName,required this.fileIndex});

  @override
  List<Object?> get props => [file,fileName];
}


class VideoFilePaused extends VideoState {
  final String videoFileId;
  final int fileIndex;
  VideoFilePaused({required this.videoFileId,required this.fileIndex});

  @override
  List<Object?> get props => [videoFileId];
}


class VideoFileResumed extends VideoState {
  final String videoFileId;
  final int fileIndex;
  VideoFileResumed({required this.videoFileId,required this.fileIndex});

  @override
  List<Object?> get props => [videoFileId];
}

class VideoFetchErrorState extends VideoState{
  final String error;
  const VideoFetchErrorState({required this.error});
}