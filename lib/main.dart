import 'package:flutter/material.dart';
import 'package:musicappapp/page/my_app.dart';
import 'package:musicappapp/landing_page.dart';
import 'package:musicappapp/view_model/project_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ProjectViewModel>(
      create: (BuildContext context) => ProjectViewModel(),
    ),
  ],
  child: const MaterialApp(home: LandingPage())));
}


