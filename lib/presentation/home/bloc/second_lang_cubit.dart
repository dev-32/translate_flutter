import 'package:flutter_bloc/flutter_bloc.dart';

class SecondLangCubit extends Cubit<String> {
  SecondLangCubit() : super("");

  void setText(String text) => emit(text);

  void clearText() => emit("");
}
