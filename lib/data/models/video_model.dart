
import 'package:get/get.dart';

class VideoModel {


  int? id;
  String? description;
  List<String>? sources;
  String? subtitle;
  String? thumb;
  String? title;
  int fileTotalSize=0;
  bool isFileDownloaded=false;
  final RxDouble fileDownloadProgress = 0.0.obs;
  String fileLocalPath='';

  VideoModel(
      {this.id,
        this.description,
        this.sources,
        this.subtitle,
        this.thumb,
        this.title});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    description = json['description']??'';
    sources = json['sources'].cast<String>();
    subtitle = json['subtitle']??'';
    thumb = json['thumb']??'';
    title = json['title']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['sources'] = this.sources;
    data['subtitle'] = this.subtitle;
    data['thumb'] = this.thumb;
    data['title'] = this.title;
    return data;
  }


}