# Water tracker app 🚰

[![Codemagic build status](https://api.codemagic.io/apps/63bb4ba82f6920dcb7c3647c/63bb4ba82f6920dcb7c3647b/status_badge.svg)](https://codemagic.io/apps/63bb4ba82f6920dcb7c3647c/63bb4ba82f6920dcb7c3647b/latest_build)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)]()
![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)
![GitHub release](https://img.shields.io/badge/release-v1.0.0-blue)
[![View DEMO](https://img.shields.io/badge/VIEW-DEMO-lightgreen.svg)](https://streamable.com/qat029)

## Project info
- This project is a simple water tracker with login functionality.
- The app is fully supported on iOS and Android.
- The app is built using the Firebase authentication and Firestore database.
- The app supports many others Firebase features such as Cloud Messaging, Crashlytics, Remote Config, etc.

## Demo
[Video](https://streamable.com/qat029) wich showcases the core functionlaity of the app with all screens developed yet.

## How to run
- Clone the project
```shell
$ git clone https://gitlab.extrawest.com/i-training/flutter/oleksii.melnychenko_google_maps_app.git_your_project_name
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
    - Initializate git repository if you hevnt already
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