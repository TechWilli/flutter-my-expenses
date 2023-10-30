import 'package:flutter/material.dart';

import 'package:flutter_my_expenses/src/screens/my_expenses_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData customTheme = ThemeData(
      fontFamily: 'Nunito',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyExpenses(),
      theme: customTheme.copyWith(
        colorScheme: customTheme.colorScheme.copyWith(
          primary: Colors.black,
          secondary: Colors.amber,
        ),
        /* eu estava colocando o estilo direto na appbar do scaffold,
        mas caso eu vá criar mais telas com scaffold, é mais prático aqui */
        appBarTheme: const AppBarTheme(
          elevation: 4,
          // backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily:
                'Nunito', // setando a font family separadamente da appbar pois a geral nao pega aqui
          ),
          centerTitle: true,
          toolbarHeight: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        // scaffoldBackgroundColor: Colors.grey.shade100,
      ),
    );
  }
}
