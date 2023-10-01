enum DraftStatus {
  draft,
  inProgress,
  done,
}

extension DraftStatusX on DraftStatus {
  bool get isDraft => this == DraftStatus.draft;
  bool get isInProgress => this == DraftStatus.inProgress;
  bool get isDone => this == DraftStatus.done;
}

extension DraftStatusFromString on String {
  DraftStatus get fromString {
    if (this == DraftStatus.draft.name) {
      return DraftStatus.draft;
    } else if (this == DraftStatus.inProgress.name) {
      return DraftStatus.inProgress;
    } else {
      return DraftStatus.done;
    }
  }
}
