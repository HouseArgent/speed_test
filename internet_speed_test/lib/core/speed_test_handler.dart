
abstract class SpeedtestHandler {
  onDownloadUpdate(var downlodData);

  onUploadUpdate(var uploadData);

  onPingJitterUpdate(var pingJitterUpdate);

  onIPInfoUpdate(var ipInfo);

  onTestIDReceived(var testIdReceived);

  onEnd();

  onCriticalFailure(var criticalFailure);
}