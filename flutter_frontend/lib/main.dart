import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/auth_provider.dart';
import 'package:flutter_frontend/providers/post_provider.dart';
import 'package:flutter_frontend/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(FlutterAuth());
}

class FlutterAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(),
        ),
        home: Wrapper(),
      ),
    );
  }
}
