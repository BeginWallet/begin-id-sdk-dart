# begin_id_sdk_dart

Demonstrates how to use the [begin_id_sdk_dart package][1]

[1]: ../


```dart
Future<void> resolveMyBeginID() async {
  final service = BeginIdService();
  var result = await service.resolveAddress(
      name: "begin", chainNumber: "1815");

  print(result["name"]);
  print(result["domain"]);
  print(result["image"]);
  print(result["address"]);
  print(result["text"]);
}
```