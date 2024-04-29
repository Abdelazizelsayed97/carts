import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_cart/features/carts/ui/pages/carts/get_carts/carts_cubit.dart';

import 'core/di/app_di.dart';
import 'features/carts/ui/pages/carts/get_carts/carts_page.dart';

void main() {
  runApp(const CartsApp());
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
}

class CartsApp extends StatelessWidget {
  const CartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 811),
      child: BlocProvider(
        create: (context) => CartsCubit(inject()),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: CartsViewPage(),
          ),
        ),
      ),
    );
  }
}
