import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/screens/files/cubit/file_cubit.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(FileInitial());
}
