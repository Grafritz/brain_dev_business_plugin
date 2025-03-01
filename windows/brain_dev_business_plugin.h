#ifndef FLUTTER_PLUGIN_BRAIN_DEV_BUSINESS_PLUGIN_H_
#define FLUTTER_PLUGIN_BRAIN_DEV_BUSINESS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace brain_dev_business {

class BrainDevBusinessPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BrainDevBusinessPlugin();

  virtual ~BrainDevBusinessPlugin();

  // Disallow copy and assign.
  BrainDevBusinessPlugin(const BrainDevBusinessPlugin&) = delete;
  BrainDevBusinessPlugin& operator=(const BrainDevBusinessPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace brain_dev_business

#endif  // FLUTTER_PLUGIN_BRAIN_DEV_BUSINESS_PLUGIN_H_
