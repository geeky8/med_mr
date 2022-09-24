/// [MRType] for managing mr type.
// ignore_for_file: constant_identifier_names

enum MRType {
  ///[MRType.EXECUTIVE] for Executive.
  EXECUTIVE,

  ///[MRType.LEADER] for Team Leader
  LEADER,
}

extension MRTypeExtension on MRType {
  String toValue() {
    switch (this) {
      case MRType.EXECUTIVE:
        return '2';
      case MRType.LEADER:
        return '1';
    }
  }

  String toText() {
    switch (this) {
      case MRType.EXECUTIVE:
        return 'MR';
      case MRType.LEADER:
        return 'Team Leader';
    }
  }
}

MRType mrTypefromValue({required String type}) {
  switch (type) {
    case '2':
      return MRType.EXECUTIVE;
    case '1':
      return MRType.LEADER;
    default:
      return MRType.EXECUTIVE;
  }
}
