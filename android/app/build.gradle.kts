plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.BigCityMeta.wakeai"
    compileSdk = 35 // Updated for path_provider_android compatibility
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.BigCityMeta.wakeai"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 21 // Ensuring minimum compatibility
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Customize APK output file name for all variants
    applicationVariants.all {
        val variant = this
        variant.outputs
            .map { it as com.android.build.gradle.internal.api.BaseVariantOutputImpl }
            .forEach { output ->
                val outputFileName = "BigCityMeta.wakeai-${variant.buildType.name}.apk"
                output.outputFileName = outputFileName
            }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
    
    // Configure lint to use our custom lint.xml file
    lint {
        disable += "ObsoleteSdkInt"
        disable += "OldTargetApi"
        baseline = file("../lint/lint-baseline.xml")
        lintConfig = file("../lint/lint.xml")
        checkReleaseBuilds = false
        abortOnError = false
        warningsAsErrors = false
    }
}

flutter {
    source = "../.."
}
