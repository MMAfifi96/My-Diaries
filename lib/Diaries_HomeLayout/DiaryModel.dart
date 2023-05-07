class diaryItemModel {
  String? diaryTitle;
  String? diaryBody;

  diaryItemModel(
    this.diaryTitle,
    this.diaryBody,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'diaryTitle': diaryTitle,
      'diaryBody': diaryBody,
    };
    return map;
  }

  diaryItemModel.fromMap(Map<String, dynamic> map) {
    diaryTitle = map['diaryTitle'];
    diaryBody = map['diaryBody'];
  }
}
