import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_redesign/blocs/login_bloc.dart';
import 'package:wechat_redesign/pages/home_page.dart';
import 'package:wechat_redesign/resources/colors.dart';
import 'package:wechat_redesign/resources/dimens.dart';
import 'package:wechat_redesign/utils/extensions.dart';

import '../widgets/loading_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Selector<LoginBloc, bool>(
          selector: (p0, p1) => p1.isLoading,
          builder: (context, isLoading, child) {
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    // backgroundColor: Colors.white,
                    automaticallyImplyLeading: true,
                  ),
                  body: Consumer<LoginBloc>(builder: (context, bloc, child) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MARGIN_LARGE_3,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_LARGE_3),
                            child: Column(
                              children: [
                                Text(
                                  'Welcome !',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: TEXT_BIG,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                                SizedBox(
                                  height: MARGIN_SMALL,
                                ),
                                Text(
                                  'Login to continue',
                                  style: TextStyle(
                                    fontSize: TEXT_REGULAR,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MARGIN_LARGE_3,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child:
                                Center(child: Image.asset('assets/login.png')),
                          ),
                          SizedBox(
                            height: MARGIN_LARGE_3,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: MARGIN_LARGE_3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextField(
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                  cursorColor: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                  decoration: InputDecoration(
                                    labelText: 'Enter your Email',
                                    labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color,
                                    ),
                                  ),
                                  onChanged: bloc.setEmail,
                                ),
                                SizedBox(
                                  height: MARGIN_SMALL,
                                ),
                                TextField(
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                  cursorColor: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                  decoration: InputDecoration(
                                    labelText: 'Enter your Password',
                                    labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color,
                                    ),
                                  ),
                                  onChanged: bloc.setPassword,
                                ),
                                SizedBox(
                                  height: MARGIN_MEDIUM_2,
                                ),
                                Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MARGIN_LARGE_3,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  bloc.onTapLogin().then((value) {
                                    debugPrint('value :: $value');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()),
                                        (route) => false);
                                  }).onError((error, stackTrace) {
                                    showSnackBar(context, '$error');
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: PRIMARY_COLOR,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: MARGIN_LARGE,
                                    vertical: MARGIN_MEDIUM,
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: TEXT_REGULAR_2X,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Visibility(
                  visible: isLoading,
                  child: const LoadingView(),
                ),
              ],
            );
          }),
    );
  }
}
