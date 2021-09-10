adb uninstall com.example.flutter_app02
adb install -r -d build/app/outputs/apk/release/app-release.apk
adb shell am start -n com.example.flutter_app02/.MainActivity