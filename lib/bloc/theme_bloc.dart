import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Cubit<ThemeMode>{
  ThemeBloc():super(ThemeMode.light);

  changeTheme(String theme)=> theme=='light' ? emit(ThemeMode.light) : emit(ThemeMode.dark);
}