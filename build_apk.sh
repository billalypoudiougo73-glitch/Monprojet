#!/bin/bash

# Configuration
export BUILD_NUMBER=1
export GRADLE_OPTS="-Xmx1024m -Dorg.gradle.daemon=false"

# Créer le dossier Android
mkdir -p ~/.android
echo "count=0" > ~/.android/repositories.cfg

# Télécharger le SDK si nécessaire
if [ ! -d "$HOME/.buildozer/android/platform/android-sdk" ]; then
    echo "Téléchargement du SDK Android..."
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O /tmp/sdk.zip
    mkdir -p ~/.buildozer/android/platform/android-sdk
    unzip -q /tmp/sdk.zip -d ~/.buildozer/android/platform/android-sdk/
    mv ~/.buildozer/android/platform/android-sdk/cmdline-tools ~/.buildozer/android/platform/android-sdk/latest
    mkdir -p ~/.buildozer/android/platform/android-sdk/cmdline-tools
    mv ~/.buildozer/android/platform/android-sdk/latest ~/.buildozer/android/platform/android-sdk/cmdline-tools/
fi

# Configurer les variables
export ANDROID_SDK_HOME="$HOME/.buildozer/android/platform/android-sdk"
export PATH="$ANDROID_SDK_HOME/cmdline-tools/latest/bin:$ANDROID_SDK_HOME/platform-tools:$PATH"

# Accepter les licences
yes | sdkmanager --licenses || true

# Installer les outils nécessaires
yes | sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2" || true

# Installer buildozer
pip install buildozer

# Créer le dossier bin
mkdir -p bin

# Construire l'APK
buildozer -v android debug

# Copier l'APK dans bin s'il a été créé ailleurs
find . -name "*.apk" -exec cp {} bin/ \;

echo "Build terminé !"
