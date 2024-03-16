import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/app_di.dart';
import 'features/carts/ui/pages/carts/carts_page.dart';

void main() {
  runApp(const CartsApp());
  WidgetsFlutterBinding.ensureInitialized();
    setupGetIt();
}

class CartsApp extends StatelessWidget {
  const CartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(375, 811),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: CratsViewPage(),
        ),
      ),
    );
  }
}
