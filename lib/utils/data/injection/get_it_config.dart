import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vinto/controller/auth_controller.dart';
import 'package:vinto/controller/checkout_controller.dart';
import 'package:vinto/controller/experience_controller.dart';
import 'package:vinto/controller/interest_controller.dart';
import 'package:vinto/controller/mood_controller.dart';
import 'package:vinto/controller/taste_controller.dart';
import 'package:vinto/data/blocs/appstate.dart';
import 'package:vinto/data/blocs/cart.dart';
import 'package:vinto/data/blocs/location.dart';
import 'package:vinto/data/blocs/order-bloc.dart';
import 'package:vinto/data/blocs/product/nearby-products.dart';
import 'package:vinto/data/blocs/product/popular.dart';
import 'package:vinto/data/blocs/search-bloc.dart';

GetIt getIt = GetIt.instance;

void initInjector() {
  getIt.registerSingleton<AppState>(new AppState());

  getIt.registerLazySingleton(() => NearbyBloc());
  getIt.registerLazySingleton(() => PopularBloc());
  getIt.registerLazySingleton(() => LocationBloc());
  getIt.registerLazySingleton(() => SearchBloc());
  getIt.registerLazySingleton(() => CartBloc());
  getIt.registerLazySingleton(() => OrderBloc());

  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => ExperienceController());
  Get.lazyPut(() => CheckoutController());
  Get.lazyPut(() => MoodController());
  Get.lazyPut(() => InterestController());
  Get.lazyPut(() => TasteController());
  // Get.lazyPut(() => HomeController());
}
