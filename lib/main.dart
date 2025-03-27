import 'package:ExpensifyX_App/data/local/db_helper.dart';
import 'package:ExpensifyX_App/data/local/session_manager.dart';
import 'package:ExpensifyX_App/ui/auth/login/bloc/login_bloc.dart';
import 'package:ExpensifyX_App/ui/auth/profile/bloc/profile_bloc.dart';
import 'package:ExpensifyX_App/ui/auth/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_routes.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.loadUserSession();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create:(context) => RegisterBloc(dbHelper: DbHelper.getInstance())),
      BlocProvider(create:(context) => LoginBloc(dbHelper: DbHelper.getInstance())),
      BlocProvider(create:(context) => ProfileBloc()),
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpensifyX App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.ROUTE_SPLASH,
      routes: AppRoutes.getRoutes(),
    );
  }
}
