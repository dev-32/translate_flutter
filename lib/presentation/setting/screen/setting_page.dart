import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/common/helpers/is_dark_mode.dart';
import 'package:translator/presentation/main/bloc/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.coffee),
            title: Text("Buy me a Coffee ❤️"),
            dense: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.nightlight),
            title: const Text("Dark Mode"),
            dense: true,
            trailing: Switch(
              activeColor: Colors.yellow.shade200,
              onChanged: (value) {
                if (value == true) {
                  context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                } else {
                  context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                }
              },
              value: context.isDarkMode,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.email),
            title: Text("Contact Us"),
            dense: true,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.star),
            title: Text("Rate Us"),
            dense: true,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.view_stream),
            title: Text("About us"),
            dense: true,
          ),
        ),
      ],
    );
  }
}
