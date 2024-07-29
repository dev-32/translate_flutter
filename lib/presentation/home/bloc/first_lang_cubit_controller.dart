import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstLangCubit extends Cubit<TextEditingController?> {
  FirstLangCubit() : super(null);
  void setText(TextEditingController controller) => emit(controller);
}
