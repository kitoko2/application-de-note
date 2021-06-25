# flutter_app12

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# plugin local auth

sur android:
J'ai changer le MainActivity.Kt

package com.example.flutter_app12

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}

sur ios add :
<key>NSFaceIDUsageDescription</key>
<string>Why is my app authenticating using face id?</string>


Puis j'ais changer le style.xml

Aller à android > app > src > main > res > values > style.xml

Changer la

<style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
à

<style name="LaunchTheme" parent="Theme.AppCompat.Light.NoActionBar">

ajouter <uses-permission android:name="android.permission.USE_FINGERPRINT"/> a androidMainifest.XML

Puis rebuilder