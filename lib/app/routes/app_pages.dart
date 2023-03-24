import 'package:Biometric/app/modules/vacation/edit_vacation_type/views/edit_vacation_type_view.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../modules/Branches/add_Branch/bindings/add_branch_binding.dart';
import '../modules/Branches/add_Branch/views/add_branch_view.dart';
import '../modules/Branches/branch_Details/bindings/branch_details_binding.dart';
import '../modules/Branches/branch_Details/views/branch_details_view.dart';

import '../modules/Branches/branch_Home/bindings/Branch_Home_binding.dart';
import '../modules/Branches/branch_Home/views/Branch_Home_view.dart';
import '../modules/Branches/general_settings/binding/branch_setting_binding.dart';
import '../modules/Branches/general_settings/view/branch_setting_view.dart';
import '../modules/Branches/list_Branch/bindings/list_branch_binding.dart';
import '../modules/Branches/list_Branch/views/list_branch_view.dart';
import '../modules/Branches/update_Branch/bindings/update_branch_binding.dart';
import '../modules/Branches/update_Branch/views/update_branch_view.dart';
import '../modules/Company/company_Details/bindings/company_Details_binding.dart';
import '../modules/Company/company_Details/views/company_Details_view.dart';
import '../modules/Company/company_Home/bindings/Company_Home_binding.dart';
import '../modules/Company/company_Home/views/Company_Home_view.dart';
import '../modules/Company/company_settings/binding/company_setting_binding.dart';
import '../modules/Company/company_settings/view/company_setting_view.dart';
import '../modules/Company/update_Company/bindings/update_company_binding.dart';
import '../modules/Company/update_Company/views/update_company_view.dart';
import '../modules/Employees/add_employee/bindings/add_employee_binding.dart';
import '../modules/Employees/add_employee/views/add_employee_view.dart';
import '../modules/Employees/add_employee/views/manage_Policies.dart';
import '../modules/Employees/employee_Details/bindings/employee_details_binding.dart';
import '../modules/Employees/employee_Details/views/employee_details_view.dart';
import '../modules/Employees/employee_Home/bindings/Employee_Home_binding.dart';
import '../modules/Employees/employee_Home/views/Employee_Home_view.dart';
import '../modules/Employees/employee_Update/bindings/update_employee_binding.dart';
import '../modules/Employees/employee_Update/views/update_employee_view.dart';
import '../modules/Employees/view_Employee/bindings/Employees_binding.dart';
import '../modules/Employees/view_Employee/views/Employees_view.dart';
import '../modules/all_presence/bindings/all_presence_binding.dart';
import '../modules/all_presence/views/all_presence_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/dashboard/bindings/attendance_binding.dart';
import '../modules/dashboard/views/attendance_view.dart';
import '../modules/detail_presence/bindings/detail_presence_binding.dart';
import '../modules/detail_presence/views/detail_presence_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/languages/view/language_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reports/allBranchesReports/binding/all_branches_reports_binding.dart';
import '../modules/reports/allBranchesReports/view/all_branches_reports_views.dart';
import '../modules/reports/allEmpsReports/binding/all_emps_reports_binding.dart';
import '../modules/reports/allEmpsReports/view/all_emps_reports_view.dart';
import '../modules/reports/branchReports/binding/branch_reports_binding.dart';
import '../modules/reports/branchReports/view/branch_reports_view.dart';
import '../modules/reports/empReports/binding/emp_reports_binding.dart';
import '../modules/reports/empReports/view/emp_reports_view.dart';
import '../modules/reports/list_Branch_Rep/bindings/list_branchRep_binding.dart';
import '../modules/reports/list_Branch_Rep/views/list_branchRep_view.dart';
import '../modules/reports/reportsHome/bindings/reports_home_binding.dart';
import '../modules/reports/reportsHome/views/reports_home_view.dart';

import '../modules/reports/view_EmployeeRep/bindings/EmployeesRep_binding.dart';
import '../modules/reports/view_EmployeeRep/views/EmployeesRep_view.dart';
import '../modules/sign_up/admin/bindings/admin_sign_up_binding.dart';
import '../modules/sign_up/admin/views/admin_sign_up_view.dart';

import '../modules/sign_up/company/bindings/company_sign_up_binding.dart';
import '../modules/sign_up/company/views/company_sign_up_view.dart';
import '../modules/update_pofile/bindings/update_pofile_binding.dart';
import '../modules/update_pofile/views/update_pofile_view.dart';
import '../modules/vacation/add_vacation_type/bindings/add_vacation_binding.dart';
import '../modules/vacation/add_vacation_type/views/add_vacation_type_view.dart';
import '../modules/vacation/denied_vacations/bindings/denied_vacations_binding.dart';
import '../modules/vacation/denied_vacations/views/denied_vacations_view.dart';
import '../modules/vacation/edit_vacation_type/bindings/edit_vacation_binding.dart';
import '../modules/vacation/my_vaction/my_vacation_binding/my_vacation_binding.dart';
import '../modules/vacation/my_vaction/my_vacation_view/my_vacation_view.dart';
import '../modules/vacation/on_vacation_employees/bindings/on_vacation_requests_binding.dart';
import '../modules/vacation/on_vacation_employees/views/on_vacation_view.dart';
import '../modules/vacation/request_vacation/views/request_vacation_view.dart';
import '../modules/vacation/vacation_Home/bindings/Vacation_Home_binding.dart';
import '../modules/vacation/vacation_Home/views/Vacation_Home_view.dart';
import '../modules/vacation/request_vacation/bindings/request_vacation_bindings.dart';

import '../modules/vacation/view_vacation_types/bindings/vacation_binding.dart';
import '../modules/vacation/view_vacation_types/views/vacation_view.dart';
import '../modules/vacation/view_vacation_requests/bindings/view_vacation_request_binding.dart';
import '../modules/vacation/view_vacation_requests/views/view_vacation_request_view.dart';

part 'app_routes.dart';

class AppPages {
  final sharedPreferences = SharedPreferences.getInstance();
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
      page: () => LoginView(
        sharedPreferences: Get.find(),
      ),
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
      page: () => ProfileView(
        sharedPreferences: Get.find(),
      ),
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
        name: _Paths.ADD_VACATION_TYPE,
        page: () => AddVacationTypeView(),
        binding: AddVacationTypeBinding()),
    GetPage(
      name: _Paths.ADD_VACATION_REQUEST,
      page: () => RequestVacationView(),
      binding: RequestVacationBinding(),
    ),
    GetPage(
        name: _Paths.ADD_BRANCH,
        page: () => AddBranchView(),
        binding: AddBranchBinding()),
    GetPage(
        name: _Paths.LIST_BRANCH,
        page: () => listBranchView(),
        binding: listBranchBinding()),
    GetPage(
        name: _Paths.ADD_COMPANY_SETTING,
        page: () => CompanySettingView(),
        binding: CompanySettingBinding()),
    GetPage(
        name: _Paths.UPDATE_BRANCH,
        page: () => UpdateBranchView(),
        binding: UpdateBranchBinding()),
    GetPage(
        name: _Paths.BRACH_SETTING,
        page: () => BranchSettingView(),
        binding: BranchSettingBinding()),
    GetPage(
        name: _Paths.BRANCH_DETAILS,
        page: () => detailBranchView(),
        binding: detailBranchBinding()),
    GetPage(
        name: _Paths.BRANCH_HOME,
        page: () => BranchHomeView(),
        binding: BranchHomeBinding()),
    GetPage(
        name: _Paths.EMPLOYEE_HOME,
        page: () => EmployeeHomeView(),
        binding: EmployeeHomeBinding()),
    GetPage(
        name: _Paths.VACATION_HOME,
        page: () => VacationHomeView(),
        binding: VacationHomeBinding()),
    GetPage(
        name: _Paths.VIEW_Vacation_TYPES,
        page: () => ListVacationTypeView(),
        binding: ListVacationTypeBinding()),
    GetPage(
        name: _Paths.LIST_VIEW_REQUESTS,
        page: () => ViewVacationRequestView(),
        binding: ViewVacationRequestBinding()),
    GetPage(
        name: _Paths.ON_VACATION,
        page: () => OnVacationView(),
        binding: OnVacationBinding()),
    GetPage(
        name: _Paths.LIST_EMPLOYEES,
        page: () => ListEmployeeView(),
        binding: ListEmployeeBinding()),
    GetPage(
        name: _Paths.EMP_DETAIL,
        page: () => EmployeeDetailView(),
        binding: EmployeeDetailBinding()),
    GetPage(
        name: _Paths.EMP_UPDATE,
        page: () => UpdateEmployeeView(),
        binding: UpdateEmployeeBinding()),
    GetPage(
        name: _Paths.COMPANY_HOME,
        page: () => CompanyHomeView(),
        binding: CompanyHomeBinding()),
    GetPage(
        name: _Paths.COMPANY_DETAILS,
        page: () => CompanyDetailsView(),
        binding: CompanyDetailsBinding()),
    GetPage(
        name: _Paths.UPDATE_COMPANY,
        page: () => UpdateCompanyView(),
        binding: UpdateCompanyBinding()),
    GetPage(
        name: _Paths.ATTENDANCE,
        page: () => AttendanceView(),
        binding: AttendanceBinding()),
    GetPage(
        name: _Paths.MANAGE_POLICIES,
        page: () => ManagePoliciesView(),
        binding: AddEmployeeBinding()),
    GetPage(
      name: _Paths.LANGUAGES,
      page: () => LanguagesView(),
    ),
    GetPage(
      name: _Paths.MY_VACATION,
      page: () => MyVacationView(),
      binding: MyVacationBinding(),
    ),
    GetPage(
        name: _Paths.EMP_REPORTS,
        page: () => EmpReportsView(),
        binding: EmpReportsBinding()),
    GetPage(
        name: _Paths.REP_HOME,
        page: () => ReportsHomeView(),
        binding: ReportsHomeBinding()),
    GetPage(
        name: _Paths.LIST_EMPLOYEES_REP,
        page: () => ListEmployeeRepView(),
        binding: ListEmployeeRepBinding()),
           GetPage(
        name: _Paths.ALL_EMPS_REP,
        page: () => AllEmpsReportsView(),
        binding: AllEmpsReportsBinding()),

 GetPage(
        name: _Paths.ALL_BRANCHES_REP,
        page: () => AllBranchesReportsView(),
        binding: AllBranchesReportsBinding()),
         GetPage(
        name: _Paths.LIST_BRANCHES_REP,
        page: () => listBranchRepView(),
        binding: listBranchRepBinding()),
             GetPage(
        name: _Paths.BRANCH_REP,
        page: () => BranchReportsView(),
        binding: BranchReportsBinding()),
        
GetPage(
        name: _Paths.DEN_VAC,
        page: () => DeniedVacationView(),
        binding: DeniedVacationBinding()),

        GetPage(
        name: _Paths.EDIT_VAC,
        page: () => EditVacationTypeView(),
        binding: EditVacationTypeBinding()),

  ];
}
