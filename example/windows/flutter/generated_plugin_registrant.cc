//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <app_links/app_links_plugin_c_api.h>
#include <brain_dev_business/brain_dev_business_plugin_c_api.h>
#include <brain_dev_tools/brain_dev_tools_plugin_c_api.h>
#include <connectivity_plus/connectivity_plus_windows_plugin.h>
#include <share_plus/share_plus_windows_plugin_c_api.h>
#include <url_launcher_windows/url_launcher_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AppLinksPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AppLinksPluginCApi"));
  BrainDevBusinessPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BrainDevBusinessPluginCApi"));
  BrainDevToolsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("BrainDevToolsPluginCApi"));
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  SharePlusWindowsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SharePlusWindowsPluginCApi"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
}
