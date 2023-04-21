import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prueba_pragma/Cats/bloc/cats_cubit.dart';
import 'package:prueba_pragma/config/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: "config/.env");

  FlutterNativeSplash.remove();

  runApp(const PruebaPragmaApp());
}

class PruebaPragmaApp extends StatelessWidget {
  const PruebaPragmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatsCubit(),
      child: MaterialApp(
        title: 'Prueba Pragma',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRouter.home,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => SafeArea(child: AppRouter.getRoute(settings)),
          );
        },
      ),
    );
  }
}
