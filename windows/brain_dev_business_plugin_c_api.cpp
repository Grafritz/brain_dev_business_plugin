#include "include/brain_dev_business/brain_dev_business_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "brain_dev_business_plugin.h"

void BrainDevBusinessPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  brain_dev_business::BrainDevBusinessPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
