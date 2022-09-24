/// [RegisterationStatus] for managing states of store.
// ignore_for_file: constant_identifier_names

enum RegisterationStatus {
  ///[RegisterationStatus.INITAL] to check whether user has done initial registeration.
  INITAL,

  // ///[RegisterationStatus.PENDING] to check whether user pending registeration.
  // PENDING,

  ///[RegisterationStatus.COMPLETE] to check whether user completed registeration.
  COMPLETE,

  ///[RegisterationStatus.LINK] to check whether user has received the link or not.
  LINK
}

extension GetRegsiterationStatus on RegisterationStatus {
  String toText() {
    switch (this) {
      case RegisterationStatus.INITAL:
        return 'Inital';
      case RegisterationStatus.COMPLETE:
        return 'Completed';
      case RegisterationStatus.LINK:
        return 'Link';
    }
  }
}

RegisterationStatus getRegisterationStatusFromValue({required String status}) {
  switch (status) {
    case '0':
      return RegisterationStatus.LINK;
    case '1':
      return RegisterationStatus.INITAL;
    default:
      return RegisterationStatus.LINK;
  }
}
