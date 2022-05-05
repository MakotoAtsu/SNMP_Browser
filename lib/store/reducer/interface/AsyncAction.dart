abstract class AsyncAction {
  Function? onExecuting;
  Function? onComplete;
  Function? onError;

  AsyncAction(
      {required this.onExecuting,
      required this.onComplete,
      required this.onError});
}
