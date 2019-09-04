library similo_annotations;

class SimiloEnums {
  static const CLASSNAME = "className";
  static const TYPE = "type";
  static const EXTEND = "extend";
  static const CONST = 1; // 001
  static const COPYWITH = 2; // 010
  static const STYLE = 4; // 100
}

class SimiloBase {
  final String className;
  final String extend;
  final int type;
  const SimiloBase({
    String className,
    String extend,
    int type,
  })  : className = className,
        extend = extend,
        type = type;
}

class CopyWith extends SimiloBase {
  const CopyWith({String className, String extend}) : super(className: className, extend: extend, type: SimiloEnums.COPYWITH);
}

class Const extends SimiloBase {
  const Const({String className, String extend}) : super(className: className, extend: extend, type: SimiloEnums.CONST);
}

class ConstCopyWith extends SimiloBase{
  const ConstCopyWith({String className, String extend}) : super(className: className, extend: extend, type: SimiloEnums.CONST | SimiloEnums.COPYWITH);
}
