# Similo - const code generator for Dart

Similo means copy or simulate in latin (according to google translate at least). And this package is simulates and generates const constructors and copyWith functions for objects in Dart.

## Features
 - const constructor generator
 - copy with function generator
 - screen scale function generator for Flutter classes
 - simple inheritence support (not fully tested)
 - flexible structure (you can create your own modifier functions using `CustomModifier` class)

## Adding dependecies

- First of all we need to annotation package as project dependency. This package makes sure annotations read correctly during compile so its required on production.

    Add 
    ```
    similo_annotations: ^1.0.3
    ```
    under  your `dependencies` in `pubspec.yaml`.

- Second we need to add code generators to our development dependicies. This package will only be used when generating the code and will not make it to the production.

    Add 
    ```
    similo: ^1.0.3
    ```
    under  your `dev_dependencies` in `pubspec.yaml`.

You can check example project in this folder to understand how your file should look like.

## Running

Simply running
```
pub run build_runner build
```
or

```
flutter packages pub run build_runner build
```
will generate required files.

This command **must be run before every build**. Dart's build system will keep track of changed files and will only generate required files. It is not recomended to add generated files (named as `*.g.dart`) to source control.

## How it does work?

Given a class, generator creates two more classes. One class for all the functions and other class for values. Value class generated so it is not needed to write a constructor with all the values. Value class is named by adding Values to your class name and function class named by adding _$ at the start of your class name. Your class' constructor is redirected to the newly generated class with a factory that gets Value class as paramater. You can change the names of the Value class and Function class using [ConstNamed](#constnamed).

## How to use

Add to begining of your file:
```dart
import 'package:similo_annotations/similo_annotations.dart';

part 'your_file_name.g.dart';
```
so we can use annotations and generated file and your file can work as one.

Add annotations for your classes and make them abstract:
```dart
@Const
abstract class Example{
}
```
It is needed the class to be marked with const for copyWith and Scale annotation to work

Add factory constructor as `const factory YourClassName(YourClassNameValues v) = _$YourClassName;` to your class:
```dart
@Const
abstract class Example{
  const factory Example(ExampleValues v) = _$Example;
}
```
so when this class constructed it will redirect it to generated class.

And you can add your functions and values in the class, the rest will be generated:
```dart
//Usage for the new class
const Example t = const Example(ExampleValues(example: "test")); 

@Const
abstract class Example{
  final String example;
  final String exampleWithDefault = "this is a default value";

  String testFunction(String toAdd){
    return example + toAdd;
  }

  const factory Example(ExampleValues v) = _$Example;
}
```
You can even add variables with default values! They will be added to constructor as overridable values automagicly!

## CopyWith and Scale
You can add CopyWith and Scale annotations to your functions to generate those functionalites!
```dart
@Const
abstract class Example{
  final String example;
  final String exampleWithDefault = "this is a default value";

  @ScallableWith(Width)
  final double scaleThis;
  //This value will be scaled with 
  
  @NonScallable
  final double dontScaleThis;

  String testFunction(String toAdd){
    return example + toAdd;
  }

  @CopyWith
  Example yourCopyWithFunctionName(ExampleValues v);
  //This functions needs to get Value class

  @Scale
  Example yourScaleFunctionName(ScreenUtil screenUtil);
  //This functions needs to get screenUtil class

  const factory Example(ExampleValues v) = _$Example;
}
```

## ConstNamed
You can customize generated class names with `@ConstNamed(className:"CustomClassName", valuesName:"CustomValuesName")`. Both of those values are nullable, and if they are null the default name explanied [before](#How-it-does-work?) will be used. Keep in mind that the values are not checked for syntax or compile, if something wrong is given it will break the build.

## But Why?
 If you have classes that needs to be const and those classes have a lot of variables writing a const constructor is a tedious job. So instead of doing that, I did the tedious work of build a code generator for dart! Of course I couldn't stop there I also implemented copy with and scale modifiers with an extra class called custom modifier so someone else can write any modifier they want for the specific variable types. Also I tried built value and it didnt let me create const classes.

## Notes
 - Dart's build system only allows generated files from files inside `lib` dictionary
 - It is a must to run build command (check [Running](#running)) if any files changed
 - Generated files generated as formatted with `dartfmt`
 - It is not advisory to change generated files but in the case of a problem it is possible to change them, keep in mind they will be replaced once build command run again (and if you find a serious issue please open an issue here)
