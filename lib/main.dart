import 'package:flutter/material.dart';
import 'package:test_api_bloc/bloc/get/cubit/getcontact_cubit.dart';
import 'package:test_api_bloc/module.dart';
import 'package:test_api_bloc/screen/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  locator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<GetcontactCubit>(
        create: (context) => getIt.call(),
        child: Home(),
      ),
    );
  }
}
