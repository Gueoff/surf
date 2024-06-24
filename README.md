# Alerte Océan


## Deploy

You want to deploy this app on Google Play store & Apple store.

### Upgrade version
First, upgrade the build version in pubspec.yaml

```bash
version: 0.0.1+X
```

### Google Play Store
Build the app bundle by running this command
```bash
flutter build appbundle 
```

The drag & drop the file build/app/outputs/bundle/release/app-release.aab into the store

### Apple Store

```bash
flutter build ipa 
```