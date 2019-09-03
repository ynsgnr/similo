library similo_annotations;

class SimiloEnums {
  static const CLASSNAME = "className";
  static const TYPE = "type";
  static const CONST = 1; // 001
  static const COPYWITH = 2; // 010
  static const STYLE = 4; // 100
}

class SimiloBase {
  final String className;
  final int type;
  const SimiloBase({
    String className,
    int type,
  })  : className = className,
        type = type;
}

class CopyWith extends SimiloBase {
  const CopyWith({String className}) : super(className: className, type: SimiloEnums.COPYWITH);
}

class Const extends SimiloBase {
  const Const({String className}) : super(className: className, type: SimiloEnums.CONST);
}

class ConstCopyWith extends SimiloBase{
  const ConstCopyWith({String className}):super(className: className, type: SimiloEnums.CONST | SimiloEnums.COPYWITH);
}
