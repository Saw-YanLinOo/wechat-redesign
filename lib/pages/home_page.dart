import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/home_bloc.dart';
import 'package:wechat_redesign/resources/colors.dart';

enum BottomNavItem {
  Moment,
  Chat,
  Contant,
  Me,
  Setting,
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) {
          return Scaffold(
            body: bloc.pages[bloc.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                bloc.changeIndex(value);
              },
              showUnselectedLabels: true,
              currentIndex: bloc.currentIndex,
              items: BottomNavItem.values.map((navigationBar) {
                return BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  icon: Image.asset(
                    'assets/icons/${navigationBar.name}.png',
                    color: bloc.currentIndex == navigationBar.index
                        ? PRIMARY_COLOR
                        : Colors.grey,
                  ),
                  label: navigationBar.name,
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
