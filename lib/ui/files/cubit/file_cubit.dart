import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(FileInitial());
}
