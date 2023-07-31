import 'package:downloadandplayvideo/data/models/video_model.dart';
import 'package:equatable/equatable.dart';

abstract class VideoEvents extends Equatable{

  const VideoEvents();

  @override
  List<Object?> get props => [];

}

class FetchVideos extends VideoEvents {
const FetchVideos();

@override
  List<Object> get props => [];

}

class DownloadVideoFile extends VideoEvents {
  final VideoModel file;
  final String localfileName;
  final int fileIndex;
  DownloadVideoFile({required this.file,required this.localfileName,required this.fileIndex});

  @override
  List<Object> get props => [];

}



