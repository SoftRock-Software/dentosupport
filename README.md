# Dento Support

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

## Overview

`flutter pub run build_runner build --delete-conflicting-outputs`
`flutter build appbundle`

## Pre-requisites 📐

| Technology | Recommended Version | Installation Guide                                                    |
| ---------- | ------------------- | --------------------------------------------------------------------- |
| Flutter    | v3.3.10             | [Flutter Official Docs](https://flutter.dev/docs/get-started/install) |
| Dart       | v2.18.6             | Installed automatically with Flutter                                  |

### Dependencies

| Package              | Purpose                                                           |
| -------------------- | ----------------------------------------------------------------- |
| animations           | Animate a page route transition                                   |
| dio                  | Http client for network request                                   |
| equatable            | Add equality to the classes                                       |
| firebase_core        | To connecting Firebase                                            |
| firebase_crashlytics | Crash reporter                                                    |
| flutter_bloc         | State management with BLoC pattern                                |
| flutter_svg          | Use as default SVG image loader, prefer use SVG as image asset    |
| flutter_typeahead    | Auto complete text input                                          |
| get_it               | Dependency Injection                                              |
| go_router            | A declarative router based on Navigation 2                        |
| grouped_list         | A flutter ListView in which list items can be grouped to sections |
| json_annotation      | Helper classes that provide code generation from JSON             |
| pinput               | Customizable Pin code input field                                 |
| shared_preferences   |                                                                   |

### Dev Dependencies

| Package            | Purpose                                 |
| ------------------ | --------------------------------------- |
| build_runner       | A build system for Dart code generation |
| go_router_builder  | Generate type safe route (Beta)         |
| json_serializable  | Automatically generate code from JSON   |
| very_good_analysis | Lint rules for Dart and Flutter         |

## Note

- https://otakoyi.software/blog/flutter-clean-architecture-with-riverpod-and-supabase
- https://stackoverflow.com/questions/63953351/how-can-i-convert-css-boxshadow-to-flutter-boxshadow
- https://github.com/flutter/flutter/issues/99663
- https://web.archive.org/web/20220325235726/https://gorouter.dev/user-input
- go_router doesn't have popUntil. For Type Safe need to depends on other pub
