import 'package:first/Animations/screens/sandBox.dart';
import 'package:first/LocalStorage/hive.dart';
import 'package:first/StateMan/Bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:first/Animations/screens/home.dart';

void main() async {
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flutter demo',
        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        // onGenerateRoute: (settings) {
        //   switch (settings.name) {
        //     case '/':
        //       return MaterialPageRoute(builder: (_) => HomeScreen());
        //     case '/details':
        //       // Extracting arguments from settings.arguments if needed
        //       var arguments = settings.arguments as Map<String, dynamic>;
        //       return MaterialPageRoute(
        //         builder: (_) => DetailsScreen(data: arguments['data']),
        //       );
        //     default:
        //       return MaterialPageRoute(builder: (_) => NotFoundScreen());
        //   }
        // },
        // routes: {
        //   '/': (context) => MyFirstPage(),
        //   '/second': (context) => MySecondPage()
        // },
        // home: ChangeNotifierProvider(
        //   create: (context) => ConterModel(),
        //   child: CounterWidget(),
        // ),
        // home: BlocProvider(
        //     create: (context) => CounterBloc(), child: const CounterWidgetBloc()),
        // home: TransactionPage(),
        home: Home());
  }
}
