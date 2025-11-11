plugins {
  id("com.android.application")
  id("org.jetbrains.kotlin.android")
  id("org.jetbrains.kotlin.plugin.serialization")
  id("com.google.devtools.ksp")
}

android {
  namespace = "com.cognopath.fastlens"
  compileSdk = 35

  defaultConfig {
    applicationId = "com.cognopath.fastlens"
    minSdk = 24
    targetSdk = 35
    versionCode = 1
    versionName = "0.1.0"
    vectorDrawables { useSupportLibrary = true }
    buildConfigField("String", "https://tbjongiaucnivhjuatju.supabase.co", "\"${project.properties["https://tbjongiaucnivhjuatju.supabase.co"]}\"")
    buildConfigField("String", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRiam9uZ2lhdWNuaXZoanVhdGp1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI2NjU0NzAsImV4cCI6MjA3ODI0MTQ3MH0.xG4Do9NFiXAd4MHjWGfKWSUxyJ-HwR4IuyXWKsVSVvU", "\"${project.properties["eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRiam9uZ2lhdWNuaXZoanVhdGp1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI2NjU0NzAsImV4cCI6MjA3ODI0MTQ3MH0.xG4Do9NFiXAd4MHjWGfKWSUxyJ-HwR4IuyXWKsVSVvU"]}\"")
    buildConfigField("String", "sk-abcdef1234567890abcdef1234567890abcdef12", "\"${project.properties["sk-abcdef1234567890abcdef1234567890abcdef12"]}\"")
  }

  buildTypes {
    release {
      isMinifyEnabled = false
      proguardFiles(
        getDefaultProguardFile("proguard-android-optimize.txt"),
        "proguard-rules.pro"
      )
    }
  }

  buildFeatures { compose = true }
  composeOptions {
    kotlinCompilerExtensionVersion = "1.5.14"
  }
  packaging {
    resources.excludes += "/META-INF/{AL2.0,LGPL2.1}"
  }
}

dependencies {
  // Compose BOM
  implementation(platform("androidx.compose:compose-bom:2024.10.01"))
  implementation("androidx.activity:activity-compose:1.9.3")
  implementation("androidx.compose.material3:material3")
  implementation("androidx.compose.ui:ui")
  implementation("androidx.compose.ui:ui-tooling-preview")
  debugImplementation("androidx.compose.ui:ui-tooling")

  // Lifecycle / ViewModel
  implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.8.6")
  implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.8.6")

  // Room + KSP
  implementation("androidx.room:room-ktx:2.6.1")
  ksp("androidx.room:room-compiler:2.6.1")

  // Add these Supabase dependencies
  implementation(platform("io.github.jan-tennert.supabase:bom:2.5.0"))
  implementation("io.github.jan-tennert.supabase:postgrest-kt")
  implementation("io.github.jan-tennert.supabase:auth-kt")
  implementation("io.github.jan-tennert.supabase:functions-kt")
  implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.6.3")
}