
import 'brain_dev_business_platform_interface.dart';

class BrainDevBusiness {
  Future<String?> getPlatformVersion() {
    return BrainDevBusinessPlatform.instance.getPlatformVersion();
  }
}
