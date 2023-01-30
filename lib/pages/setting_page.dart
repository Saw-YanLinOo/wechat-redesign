import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/setting_bloc.dart';
import 'package:wechat_redesign/blocs/theme_bloc.dart';
import 'package:wechat_redesign/pages/splash_screen_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/resources/fonts.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingBloc(),
      builder: (context, child) => Scaffold(
        body: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                'Setteing',
                style: TextStyle(
                  fontFamily: YorkieDEMO,
                  fontWeight: FontWeight.w600,
                  fontSize: TEXT_BIG,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                // ListTile(
                //   onTap: () {
                //     // if (bloc.currentTheme == ThemeType.light.name) {
                //     //   context
                //     //       .read<ThemeBloc>()
                //     //       .setTheme(context, ThemeType.dark.name);
                //     // } else {
                //     // }
                //     context
                //         .read<ThemeBloc>()
                //         .setTheme(context, ThemeType.dark.name);
                //   },
                //   title: Text(
                //     'Theme',
                //     style: TextStyle(
                //         color: Theme.of(context).textTheme.bodyMedium?.color),
                //   ),
                //   trailing: Icon(
                //     Icons.light_mode,
                //     color: Theme.of(context).iconTheme.color,
                //   ),
                // ),
                Consumer<ThemeBloc>(builder: (context, bloc, child) {
                  return ListTile(
                    onTap: () {
                      if (bloc.currentTheme == ThemeType.light.name) {
                        context
                            .read<ThemeBloc>()
                            .setTheme(context, ThemeType.dark.name);
                      } else {
                        context
                            .read<ThemeBloc>()
                            .setTheme(context, ThemeType.light.name);
                      }
                    },
                    title: Text(
                      'Theme',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    trailing: bloc.currentTheme == ThemeType.light.name
                        ? Icon(
                            Icons.light_mode,
                            color: Theme.of(context).iconTheme.color,
                          )
                        : Icon(Icons.dark_mode,
                            color: Theme.of(context).iconTheme.color),
                  );
                }),
                InkWell(
                  onTap: () {
                    // var bloc = Provider.of<SettingBloc>(context, listen: false);
                    // bloc.onTapLogout();
                    context.read<SettingBloc>().onTapLogout().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreenPage(),
                          ),
                          (route) => false);
                    });
                  },
                  child: ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    trailing: Icon(Icons.logout,
                        color: Theme.of(context).iconTheme.color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
