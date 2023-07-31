import 'package:cached_network_image/cached_network_image.dart';
import 'package:downloadandplayvideo/data/models/video_model.dart';
import 'package:downloadandplayvideo/data/network_api/url.dart';
import 'package:downloadandplayvideo/ui/video_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SingleVideoListItem extends StatelessWidget {
  final VideoModel videoData;
  final int index;
  final Function(VideoModel, int) downloadAction;
  SingleVideoListItem({Key? key, required this.videoData,required this.index,required this.downloadAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        videoData.fileDownloadProgress.value==0.0?downloadAction(videoData,index):(){};
      },
      child: Container(
        margin: EdgeInsets.only(top:8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: thumbBaseUrl+videoData.thumb!,
                height: 70,
                width: 80,
                fit: BoxFit.fill,
              ),
            ),

            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(videoData.title.toString().trim()??'',
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),

                    Row(
                      children: [
                        Text(videoData.subtitle??'',
                            style: TextStyle(
                              fontSize: 12,
                                color: Colors.grey.shade500
                            )),
                        SizedBox(width: 10,),
                        Text(bytesToMB(videoData.fileTotalSize),
                            style: TextStyle(
                              fontSize: 12,
                                color: Colors.grey.shade500
                            )),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text(videoData.description.toString().trim()??'',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600
                      ),),

                    Obx(() {
                      return Column(
                        children: [
                          videoData.fileDownloadProgress.value>0?LinearProgressIndicator(
                            value: videoData.fileDownloadProgress.value,
                            minHeight: 5,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                          ):Container(),

                          videoData.fileDownloadProgress.value<1.0?Container():
                          ElevatedButton(
                            onPressed: () {
                              openVideoView(context, videoData.fileLocalPath);
                            },
                            child: const Text(
                              "Completed, Watch Now",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      );
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String bytesToMB(int bytes) {
    double megabytes = bytes / (1024 * 1024);
    return megabytes.toStringAsFixed(2) + ' MB';
  }

  openVideoView(BuildContext context,String filePath){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoScreen(videoPath: filePath),
        ),
      );
  }
}




