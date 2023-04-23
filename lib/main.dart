import 'package:chat_app/Bloc/register_cubit.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/bloc_observer.dart';
import 'Bloc/login_cubit.dart';
import 'Pages/login_page.dart';
import 'Utilities/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   Bloc.observer = MyBlocObserver();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(
        create:((context) => RegisterCubit())),
        BlocProvider(
        create:((context) => LoginCubit()))],
       
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: LoginPage(),
          
        ),
    
    );
  }
}
