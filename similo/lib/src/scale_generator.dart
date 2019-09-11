import 'package:similo/src/custom_modifier_generator.dart';

class ScaleGen extends CustomModifier {
  const ScaleGen():super({
    "TextStyle": (String variableName)=>"""$variableName.copyWith(
        fontSize: screenUtil.setSp(this.$variableName.fontSize),
      )""",
    "EdgeInsets": (String variableName)=>"""EdgeInsets.only(
        left: screenUtil.setWidth($variableName.left),
        right: screenUtil.setWidth($variableName.right),
        top: screenUtil.setHeight($variableName.top),
        bottom: screenUtil.setHeight($variableName.bottom),
      )""",
  });
}