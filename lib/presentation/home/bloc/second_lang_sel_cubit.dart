import 'package:flutter_bloc/flutter_bloc.dart';

class SecondLangSelCubit extends Cubit<Map<String, String>> {
  SecondLangSelCubit() : super({"Hindi": "hi"});
  Map<String, String> languageMap = {
    "English": "en",
    "Gujarati": "gu",
    "Hindi": "hi",
    "Kannada": "kn",
    "Malayalam": "ml",
    "Marathi": "mr",
    "Odia (Oriya)": "or",
    "Punjabi": "pa",
    "Sindhi": "sd",
    "Tamil": "ta",
    "Telugu": "te",
    "Urdu": "ur"
  };

  void setValue(String key) => emit({key: languageMap[key]!});
}
