import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/common/helpers/is_dark_mode.dart';
import 'package:translator/presentation/main/bloc/bottom_nav_bar_cubit.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarCubit, int>(builder: (context, state) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: BottomNavigationBar(
          backgroundColor:
              context.isDarkMode ? Colors.grey[900] : Colors.grey[300],
          elevation: 0,
          currentIndex: state,
          selectedItemColor:
              context.isDarkMode ? Colors.white : Colors.grey[900],
          unselectedItemColor: context.isDarkMode ? Colors.grey : Colors.white,
          onTap: (int val) {
            context.read<BottomNavbarCubit>().updateIndex(val);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Setting",
            ),
          ],
        ),
      );
    });
  }
}
