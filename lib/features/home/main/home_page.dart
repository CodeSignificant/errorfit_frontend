import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/home/main/home_controller.dart';
import 'package:error_fit/features/home/main/home_mobile.dart';
import 'package:error_fit/features/home/main/home_tab.dart';
import 'package:error_fit/features/home/main/home_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/resources/actions.dart';
import '../../../main.dart';

class HomePage extends StatefulWidget {
  final String? tab;
  const HomePage({super.key, this.tab});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with RouteAware, WidgetsBindingObserver {
  final control = HomeController();

  @override
  void initState() {
    super.initState();
    control.init(tab: widget.tab);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    control.onResume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: HomeMobile(control: control),
        tab: HomeTab(control: control),
        web: HomeWeb(control: control),
      ),
    );
  }
}


