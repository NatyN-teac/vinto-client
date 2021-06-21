import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vinto/controller/auth_controller.dart';
import 'package:vinto/controller/checkout_controller.dart';
import 'package:vinto/controller/experience_controller.dart';
import 'package:vinto/controller/home_controller.dart';
import 'package:vinto/controller/interest_controller.dart';
import 'package:vinto/controller/mood_controller.dart';
import 'package:vinto/controller/taste_controller.dart';
import 'package:vinto/data/blocs/appstate.dart';

GetIt getIt = GetIt.instance;

void initInjector() {
  getIt.registerSingleton<AppState>(new AppState());

  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => ExperienceController());
  Get.lazyPut(() => CheckoutController());
  Get.lazyPut(() => MoodController());
  Get.lazyPut(() => InterestController());
  Get.lazyPut(() => TasteController());
  Get.lazyPut(() => HomeController());
}
