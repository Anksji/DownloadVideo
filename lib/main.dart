
import 'package:downloadandplayvideo/business_logic/bloc/bloc_observer.dart';
import 'package:downloadandplayvideo/business_logic/bloc/bloc_provider.dart';
import 'package:downloadandplayvideo/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: MyBlocProvider.blocProviders,
        child: const MaterialApp(
            title: 'Flutter Task',
            debugShowCheckedModeBanner : false,
            home: HomePage()),
    );
  }
}
