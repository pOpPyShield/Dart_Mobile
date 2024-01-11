import 'package:flutter/foundation.dart';
import 'blockchain_account.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

/// Extensions to the WalletConnect package

/// Relay is missing a toString override
extension PrintRelay on Relay {
  String get prettyPrint {
    if (data == null) {
      return protocol;
    }
    return '$protocol ($data)';
  }
}

// OK these really aren't extensions because they take a Map

/// Returns a list of Blockchain accounts for each of the namespaces in a map.
List<BlockchainAccount> namespacesToBlockchainAccounts(
    Map<String, Namespace> namespaces) {
  List<BlockchainAccount> blockchainAccounts = [];

  for (String namespace in namespaces.keys) {
    List<String>? accounts = [];
    accounts = namespaces[namespace]?.accounts ?? accounts;
    for (String accountId in accounts) {
      if (accountId.toLowerCase().contains('nan')) {
        if (kDebugMode) {
          print(
              'namespacesToBlockchainAccounts - malformed accountId: $accountId, in namespace: $namespace, namespaces: $namespaces');
        }
        continue;
      }
      blockchainAccounts
          .add(BlockchainAccount.fromAccountID(accountId: accountId));
    }
  }
  return blockchainAccounts;
}

/// Convert namespaces to a comma separated String of accounts.
String printNameSpacesAccounts(Map<String, Namespace> namespaces) {
  String accountList = '';
  for (String namespace in namespaces.keys) {
    //accountList += '[$namespace]:';
    List<String>? accounts = namespaces[namespace]?.accounts;
    if (accounts != null) {
      for (String account in accounts) {
        accountList += (accountList.isEmpty) ? account : ', $account';
      }
    }
  }
  return '[ $accountList ]';
}

/// Convert namespaces to a comma separated String of methods.
String printNameSpacesMethods(Map<String, Namespace> namespaces) {
  List<String> methodList = [];
  for (String namespace in namespaces.keys) {
    List<String>? methods = namespaces[namespace]?.methods;
    if (methods != null) {
      methodList = [...methodList, ...methods];
    }
  }
  return '[ ${methodList.join(', ')} ]';
}

/// Convert namespaces to a comma separated String of events.
String printNameSpacesEvents(Map<String, Namespace> namespaces) {
  List<String> eventList = [];
  for (String namespace in namespaces.keys) {
    List<String>? events = namespaces[namespace]?.events;
    if (events != null) {
      eventList = [...eventList, ...events];
    }
  }
  return '[ ${eventList.join(', ')} ]';
}
