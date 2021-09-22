import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination<T> {
  final int offset;
  final int size;
  final int total;
  final int pageCount;
  final int curPage;
  final bool over;
  late List<T> datas;

  Pagination({required this.offset, required this.size, required this.total, required this.pageCount, required this.curPage, required this.over});
  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

