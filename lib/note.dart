// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  bool isSelected = false;
  int id;
  String note;
  Note({required this.id, required this.note, required this.isSelected});

  Note copyWith({
    int? id,
    String? note,
    bool? isSelected,
  }) {
    return Note(
      id: id ?? this.id,
      note: note ?? this.note,
      isSelected: this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'body': note,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      note: map['body'],
      isSelected: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Note(id: $id, note: $note)';

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id && other.note == note;
  }

  @override
  int get hashCode => id.hashCode ^ note.hashCode;
}
