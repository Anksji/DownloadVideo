
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloadandplayvideo/business_logic/bloc/bloc_provider.dart';
import 'package:downloadandplayvideo/business_logic/bloc/video_bloc/bloc.dart';
import 'package:downloadandplayvideo/data/models/video_model.dart';
import 'package:downloadandplayvideo/ui/video_play_screen.dart';
import 'package:downloadandplayvideo/ui/widgets/single_list_items/video_single_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    MyBlocProvider.videoBloc.add(FetchVideos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('Videos', textAlign: TextAlign.start),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<VideoBloc, VideoState>(
          listener: (context, state) {
            if (state is VideoFetchErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Video not fetched successfully')),
              );
            }
          },
          builder: (context, state) {
            if (state is VideoLoadingProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideoFetchedState) {
              return buildVideoList(state.videoList);
            } else if(state is VideoListUpdateState){
              return buildVideoList(state.videoList);
            }
            else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget buildVideoList(List<VideoModel> videoList) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: videoList.length,
      itemBuilder: (_, index) => GestureDetector(
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: ListTile(
            title: SingleVideoListItem(
              videoData: videoList[index],
              index: index,
              downloadAction: downloadFile,
            ),
          ),
        ),
      ),
    );
  }
  downloadFile(VideoModel file, int fileIndex)async{
    print("click on download button $fileIndex");
    Directory tempDir = await getTemporaryDirectory();
    String fileName = file.sources![0].split('/').last;
    String filePath='${tempDir.path}/$fileName';
    MyBlocProvider.videoBloc.add(DownloadVideoFile(file: file, localfileName: filePath, fileIndex: fileIndex));
  }

}


