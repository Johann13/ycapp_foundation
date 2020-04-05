package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.feser.ycapp_foundation.ycapp_foundation.YcappFoundationPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    YcappFoundationPlugin.registerWith(registry.registrarFor("com.feser.ycapp_foundation.ycapp_foundation.YcappFoundationPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
