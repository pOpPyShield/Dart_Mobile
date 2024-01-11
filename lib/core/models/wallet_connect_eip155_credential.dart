import 'package:flutter/foundation.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import 'blockchain.dart';

extension TransactionPrettyPrint on Transaction {
  String get prettyPrint {
    String dataHexString = 'null';
    if (data != null) {
      dataHexString = '[ ';
      for (int i = 0; i < (data?.length ?? -1); i++) {
        dataHexString +=
            '${data?[i].toRadixString(16).padLeft(2, '0') ?? 'null'} ';
      }
      dataHexString += ']';
    }

    return '{from: ${from?.hex ?? 'null'}, to: ${to?.hex ?? 'null'}, maxGas: $maxGas, gasPrice: $gasPrice, value: $value, nonce: $nonce, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas}\ntransaction.data in bytes: $dataHexString';
  }
}

/// [signClient] WalletConnect Web3App sign client.
/// [sessionTopic] The active session for the wallet (not pairingTopic]
/// [chainId] CAIP-2 chainId (e.g. 'eip155:137')
/// [credentialAddress] EthereumAddress used for sending the transaction (e.g. pays the gas)
class WalletConnectEip155Credentials extends CustomTransactionSender {
  WalletConnectEip155Credentials(
      {required this.signEngine,
      required this.sessionTopic,
      required this.blockchain,
      required this.credentialAddress});
  final ISignEngine signEngine;
  final String sessionTopic;
  final Blockchain blockchain;
  final EthereumAddress credentialAddress;

  get chainId => blockchain.chainId;

  @override
  EthereumAddress get address => credentialAddress;

  /// Send transaction to the connected Wallet Connect wallet.  Calling application will need to
  /// launch the application URI on mobile to redirect the user to approve the transaction
  ///
  /// Credit to example/mobile/lib/ethereum_transaction_tester.dart
  /// Credit to lib/src/providers/ethereum_walletconnect_provider.dart
  @override
  Future<String> sendTransaction(Transaction transaction) async {
    if (kDebugMode) {
      print(
          'WalletConnectEip155Credentials: sendTransaction - transaction: ${transaction.prettyPrint}');
    }

    // Caller need to update credentials if session is stale
    // https://github.com/WalletConnect/WalletConnectFlutterV2/issues/176#issuecomment-1706733593
    if (!signEngine.getActiveSessions().keys.contains(sessionTopic)) {
      if (kDebugMode) {
        print(
            'sendTransaction - called with invalid sessionTopic: $sessionTopic');
      }
      return 'Internal Error - sendTransaction - called with invalid sessionTopic';
    }

    // https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sendtransaction

    SessionRequestParams sessionRequestParams = SessionRequestParams(
      method: 'eth_sendTransaction',
      params: [
        {
          // Required parameters
          'from': transaction.from?.hex ?? credentialAddress.hex,
          'to': transaction
              .to?.hex, // ok optional - if you are deploying the contract
          'data':
              (transaction.data != null) ? bytesToHex(transaction.data!) : null,
          // Optional parameters
          if (transaction.value != null)
            'value':
                '0x${transaction.value?.getInWei.toRadixString(16) ?? '0'}',
          if (transaction.maxGas != null)
            'gas': '0x${transaction.maxGas?.toRadixString(16)}',
          if (transaction.gasPrice != null)
            'gasPrice': '0x${transaction.gasPrice?.getInWei.toRadixString(16)}',
          if (transaction.nonce != null) 'nonce': transaction.nonce,
        }
      ], // Never forget params is a list too. It can be really unpleasant.
    );

    if (kDebugMode) {
      print(
          'WalletConnectEip155Credentials: sendTransaction - blockchain $blockchain, sessionRequestParams: ${sessionRequestParams.toJson()}');
    }

    final hash = await signEngine.request(
      topic: sessionTopic,
      chainId: blockchain.chainId, // CAIP-2 format: eip155:137
      request: sessionRequestParams,
    );
    return hash;
  }

  @override
  Future<EthereumAddress> extractAddress() {
    // TODO: implement extractAddress
    throw UnimplementedError();
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToSignature
    throw UnimplementedError();
  }

  @override
  MsgSignature signToEcSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    // TODO: implement signToEcSignature
    throw UnimplementedError();
  }
}
