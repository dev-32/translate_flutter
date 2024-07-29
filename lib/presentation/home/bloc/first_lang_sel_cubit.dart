import 'package:flutter_bloc/flutter_bloc.dart';

class FirstLangSelCubit extends Cubit<Map<String, String>> {
  FirstLangSelCubit() : super({"English": "en"});
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
