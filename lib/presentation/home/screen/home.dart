import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:translator/common/helpers/is_dark_mode.dart';
import 'package:translator/presentation/home/bloc/first_lang_cubit_controller.dart';
import 'package:translator/presentation/home/bloc/first_lang_sel_cubit.dart';
import 'package:translator/presentation/home/bloc/loading_cubit.dart';
import 'package:translator/presentation/home/bloc/second_lang_cubit.dart';
import 'package:translator/presentation/home/bloc/second_lang_sel_cubit.dart';
import 'package:translator/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController firstLang = TextEditingController();
  TextEditingController secondLang = TextEditingController();
  List<String> languageKeys = [
    "English",
    "Gujarati",
    "Hindi",
    "Kannada",
    "Malayalam",
    "Marathi",
    "Odia (Oriya)",
    "Punjabi",
    "Sindhi",
    "Tamil",
    "Telugu",
    "Urdu"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _customRow(context, size),
          BlocBuilder<FirstLangSelCubit, Map<String, String>>(
              builder: (context, state) {
            return _customContainer(context, size, state.keys.toList()[0],
                context.read<FirstLangCubit>().state ?? firstLang, true);
          }),
          BlocBuilder<LoadingCubit, bool>(
            builder: (context, state) => Skeletonizer(
                enabled: state,
                child: BlocBuilder<SecondLangSelCubit, Map<String, String>>(
                    builder: (contex, state) {
                  return _customContainer(
                      context, size, state.keys.toList()[0], secondLang, false);
                })),
          ),
        ],
      ),
    ));
  }

  Widget _customContainer(BuildContext context, Size size, String title,
      TextEditingController controller, bool enabled) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      height: size.height * 0.3,
      width: size.width,
      decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey[300] : Colors.white,
          borderRadius: BorderRadius.circular(24)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.017),
            ),
            enabled
                ? TextField(
                    style: TextStyle(fontSize: size.height * 0.018),
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(border: InputBorder.none),
                    enabled: enabled,
                    onChanged: (String str) {
                      context.read<FirstLangCubit>().setText(controller);
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      context.read<SecondLangCubit>().state,
                      style: TextStyle(fontSize: size.height * 0.018),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _customRow(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showMaterialModalBottomSheet(
                backgroundColor:
                    context.isDarkMode ? Colors.grey.shade600 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                context: context,
                builder: (context) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      height: size.height / 2,
                      child: ListView.builder(
                          itemCount: languageKeys.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // context.read<FirstLangCubit>().state!.clear();
                                context
                                    .read<FirstLangSelCubit>()
                                    .setValue(languageKeys[index]);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Text(
                                  languageKeys[index],
                                  style: TextStyle(
                                    fontSize: size.height * 0.017,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ));
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: size.height * 0.06,
            width: size.width / 4,
            decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.grey[300] : Colors.white,
                borderRadius: BorderRadius.circular(24)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<FirstLangSelCubit, Map<String, String>>(
                    builder: (context, state) {
                  return Text(
                    state.keys.toList()[0],
                    style: TextStyle(
                        fontSize: state.keys.toList()[0].length < 8
                            ? size.height * 0.016
                            : size.height * 0.014),
                  );
                }),
                const SizedBox(
                  width: 3,
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            context.read<LoadingCubit>().changeVal(true);
            context.read<SecondLangCubit>().clearText();
            if (context.read<FirstLangCubit>().state != null) {
              final res = await TranslateApiService().translate(
                  context.read<FirstLangCubit>().state!.text, context);

              res.fold((l) {
                context.read<LoadingCubit>().changeVal(false);
              },
                  (r) => {
                        context.read<LoadingCubit>().changeVal(false),
                        print(r)
                      });
            }
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: size.height * 0.06,
            width: size.width / 6,
            decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.grey[300] : Colors.white,
                borderRadius: BorderRadius.circular(24)),
            child: const Icon(Icons.translate),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showMaterialModalBottomSheet(
                backgroundColor:
                    context.isDarkMode ? Colors.grey.shade600 : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                context: context,
                builder: (context) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      height: size.height / 2,
                      child: ListView.builder(
                          itemCount: languageKeys.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.read<SecondLangCubit>().clearText();
                                context
                                    .read<SecondLangSelCubit>()
                                    .setValue(languageKeys[index]);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Text(
                                  languageKeys[index],
                                  style: TextStyle(
                                    fontSize: size.height * 0.017,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ));
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            height: size.height * 0.06,
            width: size.width / 4,
            decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.grey[300] : Colors.white,
                borderRadius: BorderRadius.circular(24)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<SecondLangSelCubit, Map<String, String>>(
                    builder: (context, state) {
                  return Text(
                    state.keys.toList()[0],
                    style: TextStyle(
                        fontSize: state.keys.toList()[0].length < 8
                            ? size.height * 0.016
                            : size.height * 0.014),
                  );
                }),
                const SizedBox(
                  width: 3,
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
