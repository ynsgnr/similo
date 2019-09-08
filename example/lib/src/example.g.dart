// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// Generator: ClassDefiner
// **************************************************************************

class _$Example implements Example {
  final ExampleValues _values;

  const _$Example(ExampleValues v) : this._values = v;
  String testFunction(String toAdd) {
    return example + toAdd;
  }

  //Getters
  get example => _values.example;
  get exampleWithDefault => _values.exampleWithDefault;
}

//Values
class ExampleValues {
  //Define variables with types
  final String example;
  final String exampleWithDefault;

  //Write const constructor
  const ExampleValues({
    this.example,
    this.exampleWithDefault = "this is a default value",
  });
}
