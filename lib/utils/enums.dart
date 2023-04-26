enum RequestType {
  get,
  post,
  patch,
  put,
  delete,
}

enum ToastTypes {
  normal,
  success,
  error,
}

enum InProgressActivityStatus {
  started,
  completed,
  submitted,
  empty,
}

extension InProgressActivityStatusExtention on InProgressActivityStatus {
  String get value {
    switch (this) {
      case InProgressActivityStatus.started:
        return "Started";
      case InProgressActivityStatus.completed:
        return "Completed";
      case InProgressActivityStatus.submitted:
        return "Submitted";
      case InProgressActivityStatus.empty:
        return "Empty";
      default:
        return "Empty";
    }
  }
}

enum MarkerIds {
  user,
  visit,
}

extension MarkerIdsExtention on MarkerIds {
  String get value {
    switch (this) {
      case MarkerIds.user:
        return "user";
      case MarkerIds.visit:
        return "visit";
      default:
        return "user";
    }
  }
}
