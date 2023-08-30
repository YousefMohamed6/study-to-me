import 'package:hive/hive.dart';
part 'note_model.g.dart';

//dart run build_runner build
@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
   String title;
  @HiveField(1)
   String content;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final int color;

  NoteModel({
    required this.color,
    required this.title,
    required this.content,
    required this.date,
  });

}
