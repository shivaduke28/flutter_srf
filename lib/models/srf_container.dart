import 'package:freezed_annotation/freezed_annotation.dart';
import 'srf_metadata.dart';

part 'srf_container.freezed.dart';
part 'srf_container.g.dart';

@freezed
sealed class SrfContainer with _$SrfContainer {
  const factory SrfContainer({
    required String id,
    required String name,
    required String path,
    required SrfMetadata metadata,
    required List<String> audioFiles,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) = _SrfContainer;

  factory SrfContainer.fromJson(Map<String, dynamic> json) =>
      _$SrfContainerFromJson(json);
}
