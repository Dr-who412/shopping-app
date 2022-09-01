import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/modules/login/cubit/states.dart';
import 'package:shopping/shared/blocObserver.dart';
import 'package:shopping/shared/componant/constance.dart';
import 'package:shopping/shared/network/remote/Dio_Helper.dart';
import 'package:shopping/shared/shared_preference/cachHelper.dart';
import 'package:shopping/shared/styles/thems.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'layout/home_layout/home.dart';
import 'modules/home_modules/home_cubit/cubit.dart';
import 'modules/login/cubit/cubit.dart';
import 'modules/login/login.dart';
import 'modules/onboarding/onboardingpage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  await CacheHelper.init();

  late Widget widget;
  bool? onBoarding = CacheHelper.getdata(key: 'onBoarding');
  token = CacheHelper.getdata(key: 'token') ?? '';
  if (onBoarding != null) {
    if (token != null)
      widget = home();
    else
      widget = login();
  } else {
    widget = onBordingPage();
  }
  runApp(MyApp(
    startwidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final startwidget;
  MyApp({
    required this.startwidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHome()
              ..getCategory()
              ..getFavorite()
              ..getProfile()),
      ],
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          FlutterNativeSplash.remove();
          return MaterialApp(
            builder: (context, child) => ResponsiveWrapper.builder(child,
                maxWidth: 1200,
                minWidth: 480,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(480, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ],
                background: Container(color: Color(0xFFF5F5F5))),
            initialRoute: "/",
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme,
            home: startwidget,
          );
        },
      ),
    );
  }
}
