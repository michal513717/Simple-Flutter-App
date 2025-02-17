import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:sfa/providers/project_provider.dart';
import 'package:sfa/providers/task_provider.dart';
import 'package:sfa/screens/home_screen.dart';
import 'package:sfa/screens/project_task_managment_screen.dart';
import 'package:sfa/screens/tasks_managment_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initLocalStorage();

  runApp(MyApp(localStorage: localStorage));
}


class MyApp extends StatelessWidget {
  final LocalStorage localStorage;

  const MyApp({ super.key, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => TaskProvider(localStorage)),
      ChangeNotifierProvider(create: (_) => ProjectProvider(localStorage))
    ],
    child: MaterialApp(
      title: 'Time Tracking',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/manage_tasks': (context) => TasksManagmentScreen(),
        '/manage_projects': (context) => ProjectTaskManagementScreen()
      },
    )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: HomeScreen(),
  //   );
  // }
}