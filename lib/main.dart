import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app.dart';
import 'core/bloc_observer.dart';
import 'di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await initializeDependencies();


  runApp(const MyApp());
}

