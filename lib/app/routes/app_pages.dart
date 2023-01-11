import 'package:get/get.dart';
import 'package:presence/app/modules/Branches/update_Branch/bindings/update_branch_binding.dart';
import 'package:presence/app/modules/Branches/update_Branch/views/update_branch_view.dart';

import 'package:presence/app/modules/add_employee/bindings/add_employee_binding.dart';
import 'package:presence/app/modules/add_employee/views/add_employee_view.dart';
import 'package:presence/app/modules/all_presence/bindings/all_presence_binding.dart';
import 'package:presence/app/modules/all_presence/views/all_presence_view.dart';
import 'package:presence/app/modules/change_password/bindings/change_password_binding.dart';
import 'package:presence/app/modules/change_password/views/change_password_view.dart';
import 'package:presence/app/modules/company_settings/binding/company_setting_binding.dart';
import 'package:presence/app/modules/company_settings/view/company_setting_view.dart';
import 'package:presence/app/modules/detail_presence/bindings/detail_presence_binding.dart';
import 'package:presence/app/modules/detail_presence/views/detail_presence_view.dart';
import 'package:presence/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:presence/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:presence/app/modules/home/bindings/home_binding.dart';
import 'package:presence/app/modules/home/views/home_view.dart';
import 'package:presence/app/modules/login/bindings/login_binding.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:presence/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:presence/app/modules/new_password/views/new_password_view.dart';
import 'package:presence/app/modules/profile/bindings/profile_binding.dart';
import 'package:presence/app/modules/profile/views/profile_view.dart';
import 'package:presence/app/modules/sign_up/admin/bindings/admin_sign_up_binding.dart';
import 'package:presence/app/modules/sign_up/company/bindings/company_sign_up_binding.dart';
import 'package:presence/app/modules/sign_up/company/views/company_sign_up_view.dart';
import 'package:presence/app/modules/update_pofile/bindings/update_pofile_binding.dart';
import 'package:presence/app/modules/update_pofile/views/update_pofile_view.dart';
import 'package:presence/app/modules/vacation/add_vacation_type/bindings/add_vacation_binding.dart';
import 'package:presence/app/modules/vacation/add_vacation_type/views/add_vacation_type_view.dart';

import '../modules/Branches/add_Branch/bindings/add_branch_binding.dart';
import '../modules/Branches/add_Branch/views/add_branch_view.dart';
import '../modules/Branches/branch_dialog/binding/branch_setting_binding.dart';
import '../modules/Branches/branch_dialog/view/branch_setting_view.dart';
import '../modules/Branches/general_settings/binding/branch_setting_binding.dart';
import '../modules/Branches/general_settings/view/branch_setting_view.dart';
import '../modules/Branches/list_Branch/bindings/list_branch_binding.dart';
import '../modules/Branches/list_Branch/views/list_branch_view.dart';
import '../modules/sign_up/admin/views/admin_sign_up_view.dart';
import '../modules/vacation/vacation_request/bindings/request_vacation_bindings.dart';
import '../modules/vacation/vacation_request/views/request_vacation_view.dart';
import '../modules/vacation/view_vacation/bindings/vacation_binding.dart';
import '../modules/vacation/view_vacation/views/vacation_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_POFILE,
      page: () => UpdatePofileView(),
      binding: UpdatePofileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENCE,
      page: () => DetailPresenceView(),
      binding: DetailPresenceBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EMPLOYEE,
      page: () => AddEmployeeView(),
      binding: AddEmployeeBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.ALL_PRESENCE,
      page: () => AllPresenceView(),
      binding: AllPresenceBinding(),
    ),
    GetPage(
        name: _Paths.COMPANYSIGNUP,
        page: () => CompanySignUpView(),
        binding: SignUpBinding()),
    GetPage(
        name: _Paths.ADMINSIGNUP,
        page: () => AdminSignUpView(),
        binding: AdminSignUpBinding()),
    GetPage(
        name: _Paths.ADMINSIGNUP,
        page: () => AdminSignUpView(),
        binding: AdminSignUpBinding()),
    GetPage(
        name: _Paths.ADD_VACATION_TYPE,
        page: () => AddVacationTypeView(),
        binding: AddVacationTypeBinding()),
    GetPage(
        name: _Paths.VACATION_TYPE,
        page: () => VacationTypeView(),
        binding: VacationTypeBinding()),
    GetPage(
        name: _Paths.ADD_VACATION_REQUEST,
        page: () => RequestVacationView(),
        binding: RequestVacationBinding()),
    GetPage(
        name: _Paths.Add_Branch,
        page: () => AddBranchView(),
        binding: AddBranchBinding()),
    GetPage(
        name: _Paths.list_Branch,
        page: () => listBranchView(),
        binding: listBranchBinding()),
        GetPage(
        name: _Paths.ADD_COMPANY_SETTING,
        page: () => CompanySettingView(),
        binding: CompanySettingBinding()),

 GetPage(
        name: _Paths.Update_Branch,
        page: () => UpdateBranchView(),
        binding: UpdateBranchBinding()),

 GetPage(
        name: _Paths.Branch_Options,
        page: () => BranchOptionsView(),
        binding: BranchOptionBinding()),

 GetPage(
        name: _Paths.Branch_Setting,
        page: () => BranchSettingView(),
        binding: BranchSettingBinding()),



  ];
}
