import 'package:begin_id_sdk_dart/begin_id_sdk_dart.dart';
import 'package:begin_id_sdk_dart/const.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "test address resolving",
    () async {
      final service = BeginIdService();
      var result = await service.resolveAddress(
          name: "begin", chainNumber: cardanoChainNumber);
      expect(result["name"], "begin");
      expect(result["domain"], "begin.bgin.id");
      expect(result["address"],
          "addr1q84x3qh7e0q6fldmj5mnk89vjlvgncsw5g9dmxmel4qt00j04mm39fw8l4pewc59xl59v7zszwye9vhuh3zwft8e5j9sslflq0");
    },
  );

  test(
    "test address resolving failing with exception",
    () {
      final service = BeginIdService();
      expect(
          () => service.resolveAddress(
              name: "begin_XQ1404034930cksha__111!!",
              chainNumber: cardanoChainNumber),
          throwsA(isA<Exception>()));
    },
  );

  test(
    "test stakeAddress reverse resolving",
    () async {
      final service = BeginIdService();
      var result = await service.resolveAddressReverse(
        address: "stake1u986aacj5hrl6suhv2zn06zk0pgp8zvjkt7tc38y4nu6fzcsg3cxt",
        chainNumber: cardanoChainNumber,
      );

      expect(result["name"], "begin");
      expect(result["domain"], "begin.bgin.id");
      expect(result["address"],
          "addr1q84x3qh7e0q6fldmj5mnk89vjlvgncsw5g9dmxmel4qt00j04mm39fw8l4pewc59xl59v7zszwye9vhuh3zwft8e5j9sslflq0");
    },
  );

  test(
    "test paymentAddress reverse resolving",
    () async {
      final service = BeginIdService();
      var result = await service.resolveAddressReverse(
        address:
            "addr1q84x3qh7e0q6fldmj5mnk89vjlvgncsw5g9dmxmel4qt00j04mm39fw8l4pewc59xl59v7zszwye9vhuh3zwft8e5j9sslflq0",
        chainNumber: cardanoChainNumber,
      );

      expect(result["name"], "web3");
      expect(result["domain"], "web3.bgin.id");
      expect(result["address"],
          "addr1q84x3qh7e0q6fldmj5mnk89vjlvgncsw5g9dmxmel4qt00j04mm39fw8l4pewc59xl59v7zszwye9vhuh3zwft8e5j9sslflq0");
    },
  );
}
