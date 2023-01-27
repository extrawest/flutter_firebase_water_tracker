# Water tracker app 🚰

[![Codemagic build status](https://api.codemagic.io/apps/63bb4ba82f6920dcb7c3647c/63bb4ba82f6920dcb7c3647b/status_badge.svg)](https://codemagic.io/apps/63bb4ba82f6920dcb7c3647c/63bb4ba82f6920dcb7c3647b/latest_build)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)]()
![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)
![GitHub release](https://img.shields.io/badge/release-v1.0.0-blue)
[![View DEMO](https://img.shields.io/badge/VIEW-DEMO-lightgreen.svg)]()

## Project info
- This project is a water tracker app connected to Firebase.
- The app is fully supported on iOS and Android.
- The app is built using the Firebase authentication and Firestore database.
- The app uses others Firebase Services such as Cloud Messaging, Crashlytics, Remote Config, etc.
- The covered with Unit Tests, Widget Tests and Integration Tests.

## Demo

## How to run
- Clone the project
```shell
$ git clone https://github.com/extrawest/flutter_firebase_water_tracker.git
```
- Install dependencies
```shell
$ flutter pub get
```
- Configure Firebase
```shell
 $ flutterfire configure
```
- Run the app
```shell
$ flutter run
```
- Optional but highly recommended to setup pre-push hook
    - Initialize git repository if you haven't already
    ```shel
        $ git init
    ```
    - add sh script to git hooks
    ```shel
        $ ln -s pre-push.sh .git/hooks/pre-push
    ```

## How to test
- To run all test
```shel
$ flutter test
```
- To generate codecovarege:
    - Run test with additional flag
    ```shel
    $ flutter test --coverage
    ```
  this results into **coverage/lcov.info** file creation
    - Generate html file using previosly generated lcov file
    ```shel
    $ genhtml coverage/lcov.info -o coverage/html
    ```
    - Use **coverage/html/index html** to view current project's codecoverage
- In order to run shader warm ups use:
```shell
$ flutter drive --profile --cache-sksl --write-sksl-on-exit sksl_shader01.json --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

#### Maintained by *Lesha Melnychenko*

[Extrawest.com](https://www.extrawest.com), 2023