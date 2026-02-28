allprojects {
    repositories {
        google()
        mavenCentral()
    }
    configurations.all {
        resolutionStrategy {
            force("androidx.core:core-ktx:1.10.1")
            force("androidx.core:core:1.10.1")
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    afterEvaluate {
        if (plugins.hasPlugin("com.android.library")) {
            configure<com.android.build.gradle.LibraryExtension> {
                compileSdk = 36
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
    
    // Fix AGP 8+ namespace requirement for isar_flutter_libs
    plugins.withId("com.android.library") {
        configure<com.android.build.gradle.LibraryExtension> {
            compileSdk = 36 // Forced compileSdk to fix lStar missing attr error and satisfy plugin requirements
            if (namespace == null) {
                namespace = "dev.isar.${project.name}"
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
