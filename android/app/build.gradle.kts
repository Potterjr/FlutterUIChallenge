plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ex_ui_shoping"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions { jvmTarget = JavaVersion.VERSION_11.toString() }

    defaultConfig {
        applicationId = "com.example.ex_ui_shoping"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "default"
productFlavors {
    create("staging") {
        dimension = "default"
        applicationIdSuffix = ".staging"
        resValue("string", "app_name", "Ex UI Shopping (Staging)")
        buildConfigField("String", "FLAVOR_ENV", "\"staging\"")
    }
    create("production") {
        dimension = "default"
        applicationIdSuffix = ".production"
        resValue("string", "app_name", "Ex UI Shopping")
        buildConfigField("String", "FLAVOR_ENV", "\"production\"")
    }
}


    buildFeatures {
        buildConfig = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
          
        }
        debug {
            isDebuggable = true
        }
    }
}

androidComponents {
    beforeVariants(
        selector().withBuildType("release").withFlavor("default" to "staging")
    ) { it.enable = false }

    beforeVariants(
        selector().withBuildType("debug").withFlavor("default" to "production")
    ) { it.enable = false }
}

flutter {
    source = "../.."
}
