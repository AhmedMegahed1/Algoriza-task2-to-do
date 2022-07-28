import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/theme.dart';
import 'package:todo/core/util/cubit/todo_cubit.dart';
import 'package:todo/features/homescreen/presentation/page/home_screen.dart';
import 'package:todo/features/splash/presentation/page/splash_screen.dart';



late bool islogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
            create: (BuildContext context) => AppCubit()..createDatabase()),
      ],
      child: MaterialApp(
          title: 'Notes',
          theme: Themes.light,
          darkTheme: Themes.dark,
          debugShowCheckedModeBanner: false,
          home: const SplashPage()),
    );
  }
}
