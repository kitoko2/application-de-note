# application-de-note
application de note pour android et ios
# Android
apk disponible dans le ficher PoyNote\build\app\outputs\flutter-apk\app-armeabi-v7a-release.ap

# implementations
seul la fonction "Prise en main" dans le end drawer n'as pas été implementer.

nouvelle fonctionnalitées anglais/francais ajoutés.
possibilité de modifier un titre.
possibilité de securiser ces notes avec empreinte digital.

# plugin local auth

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


Puis j'ais changer le style.xml

Aller à android > app > src > main > res > values > style.xml

Changer la

<style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
à

<style name="LaunchTheme" parent="Theme.AppCompat.Light.NoActionBar">

ajouter <uses-permission android:name="android.permission.USE_FINGERPRINT"/> a androidMainifest.XML

Puis rebuilder
