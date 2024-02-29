part of 'download_cubit.dart';

@freezed
class DownloadState with _$DownloadState {
  const factory DownloadState.initial() = _Initial;
  const factory DownloadState.loading() = _Loading;
  const factory DownloadState.downloading(double progress) = _Downloading;
  const factory DownloadState.success() = _Success;
  const factory DownloadState.error(Exception error) = _Error;
}
