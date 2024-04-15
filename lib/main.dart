import 'package:crud_project/service/service.dart';
import 'package:crud_project/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/logic.dart';

void main() {
  RestApiService service = RestApiService();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<LogicalService>(
            create: (context) => LogicalService(service))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      )));
}
