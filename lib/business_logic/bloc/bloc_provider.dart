
import 'package:downloadandplayvideo/business_logic/bloc/video_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocProvider{
  static final videoBloc = VideoBloc();

  static final List<BlocProvider> blocProviders=[
    BlocProvider<VideoBloc>(
      create:(context) => videoBloc,lazy: true,),
  ];

  static void dispose(){
    videoBloc.close();
  }

  static final MyBlocProvider _instance = MyBlocProvider._internal();

  factory MyBlocProvider() {
    return _instance;
  }

  MyBlocProvider._internal();

}