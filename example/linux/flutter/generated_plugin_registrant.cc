//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <brain_dev_business/brain_dev_business_plugin.h>
#include <brain_dev_tools/brain_dev_tools_plugin.h>
#include <gtk/gtk_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) brain_dev_business_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BrainDevBusinessPlugin");
  brain_dev_business_plugin_register_with_registrar(brain_dev_business_registrar);
  g_autoptr(FlPluginRegistrar) brain_dev_tools_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BrainDevToolsPlugin");
  brain_dev_tools_plugin_register_with_registrar(brain_dev_tools_registrar);
  g_autoptr(FlPluginRegistrar) gtk_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "GtkPlugin");
  gtk_plugin_register_with_registrar(gtk_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
