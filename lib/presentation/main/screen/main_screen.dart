import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/presentation/home/screen/home.dart';
import 'package:translator/presentation/main/bloc/bottom_nav_bar_cubit.dart';
import 'package:translator/presentation/main/widgets/bottom_nav_bar.dart';
import 'package:translator/presentation/setting/screen/setting_page.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T r a n s l a t e'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<BottomNavbarCubit, int>(builder: (context, state) {
        return state == 0 ? const HomeScreen() : const SettingPage();
      }),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
