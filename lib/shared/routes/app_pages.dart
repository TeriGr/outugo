// holds definition of pages based on routes.
// Includes bindings and arguments needed for each page
import 'package:get/get.dart';
import 'package:outugo_flutter_mobile/shared/routes/app_routes.dart';
import 'package:outugo_flutter_mobile/view/bindings/home_bindings.dart';
import 'package:outugo_flutter_mobile/view/pages/change_password_page.dart';
import 'package:outugo_flutter_mobile/view/pages/checkin_system_page.dart';
import 'package:outugo_flutter_mobile/view/pages/edit_profile_page.dart';
import 'package:outugo_flutter_mobile/view/pages/forgot_password_page.dart';
import 'package:outugo_flutter_mobile/view/pages/home_page.dart';
import 'package:outugo_flutter_mobile/view/pages/home_visit_screen.dart';
import 'package:outugo_flutter_mobile/view/pages/login_page.dart';
import 'package:outugo_flutter_mobile/view/pages/pet_parent_page.dart';
import 'package:outugo_flutter_mobile/view/pages/resources_page.dart';
import 'package:outugo_flutter_mobile/view/pages/signup_page.dart';
import 'package:outugo_flutter_mobile/view/pages/summary_screen.dart';
import 'package:outugo_flutter_mobile/view/pages/visit_detail_page.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.visitDetailPage,
      page: () => VisitDetailPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.homeDetailPage,
      page: () => HomeVisitDetailPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.summaryPage,
      page: () => VisitSummaryPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.petParentPage,
      page: () => PetParentNotesPage(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: AppRoutes.editprofilePage,
      page: () => EditProfilePage(),
    ),
    GetPage(
      name: AppRoutes.changePasswordPage,
      page: () => ChangePasswordPage(),
    ),
    GetPage(
      name: AppRoutes.classicCheckinPage,
      page: () => CheckinSystemPage(),
    ),
    GetPage(
      name: AppRoutes.resourcesPage,
      page: () => ResourcesPage(),
    ),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.signUpPage,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordPage,
      page: () => ForgotPasswordPage(),
    ),
  ];
}
