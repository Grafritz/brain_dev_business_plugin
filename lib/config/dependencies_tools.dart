import 'package:brain_dev_business/controllers/business_controller.dart';
import 'package:brain_dev_business/repository/user_repository.dart';
import 'package:get/get.dart';

/*Future<Map<String, Map<String, String>>>*/
initBusinessDependencies() async
{
  //TODO: Very important to implementer the dependencies  [ brain_dev_tools ] before

  //region [ Repository ]
  Get.lazyPut(() => UserRepository(apiClient: Get.find(), sharedPreferences: Get.find(),), fenix: true);
  //endregion

  //region [ Controller ]
  Get.lazyPut(() => BusinessController(apiClient: Get.find(), userRepository: Get.find(), sharedPreferences: Get.find(),), fenix: true);
  //endregion
}
