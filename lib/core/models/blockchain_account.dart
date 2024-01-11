import 'package:flutter/foundation.dart';
import 'blockchain.dart';
import 'package:web3dart/web3dart.dart';

/// CAIP-10 Account ID https://chainagnostic.org/CAIPs/caip-10
class BlockchainAccount {
  /// hex String representation of address
  late final String accountAddress;
  late final Blockchain blockchain;

  /// list of ENS or Unstoppable names (aliases) associated with address (and associated blockchain)
  List<String> aliases = [];

  BlockchainAccount({required this.blockchain, required this.accountAddress}) {
    verifyCAIP10Format();
  }

  BlockchainAccount.fromAccountID({required String accountId}) {
    //# Ethereum mainnet (canonicalized with [EIP-55][] checksum)
    // eip155:1:0xab16a96D359eC26a11e2C2b3d8f8B8942d5Bfcdb
    List<String> accountComponents = accountId.split(':');
    if (accountComponents.length != 3) {
      throw 'Malformed accountId: $accountId. Missing : separator?';
    } else {
      // Keep the : in the CAIP-2 chainId
      Blockchain? blockchainMatch = Blockchain.fromChainId(
          '${accountComponents[0]}:${accountComponents[1]}');
      if (blockchainMatch != null) {
        blockchain = blockchainMatch;
        accountAddress = accountComponents[2];
      } else {
        throw 'Invalid Blockchain chainId  ${accountComponents[0]}:${accountComponents[1]}';
      }
    }
    verifyCAIP10Format();
  }

  // TODO: Are there case sensitive addresses in your blockchain?  I normalized to lowercase for comparisons
  @override
  bool operator ==(Object other) {
    if (other is BlockchainAccount) {
      return (other.blockchain == blockchain) &&
          (other.accountAddress.toLowerCase() == accountAddress.toLowerCase());
    }
    return false;
  }

  // TODO: Are there case sensitive addresses in your blockchain?  I normalized to lowercase for comparisons
  @override
  int get hashCode => Object.hash(blockchain, accountAddress.toLowerCase());

  /// CAIP-10 formatted address
  get accountId => ('${blockchain.chainId}:$accountAddress');

  /// CAIP-2 Chain ID
  get chainId => blockchain.chainId;
  get eip155ChainId => blockchain.eip155ChainId;

  /// CAIP-2 namespace
  get namespace => blockchain.namespace;

  /// CAIP- referece
  get reference => blockchain.reference;
  get accountAddressShort {
    // TODO: implement short name based on chainId
    if ((namespace == 'eip155') && accountAddress.length > 16) {
      return ('${accountAddress.substring(0, 6)}...${accountAddress.substring(accountAddress.length - 4)}');
    } else {
      // Don't fail, but don't shorten either
      return accountAddress;
    }
  }

  /// Block explorer url showing the history of the account
  get explorerUrl {
    String explorerUrl = blockchain.blockExplorerUrl ?? '';
    if (explorerUrl.isNotEmpty) {
      explorerUrl = '$explorerUrl/address/$accountAddress';
    }
    return explorerUrl;
  }

  /// Retrieves the first/primary alias for this account
  ///
  /// TODO: internally manage names, caching and expirations / refreshing?
  String get domainName => (aliases.isNotEmpty) ? aliases.first : '';
  List<String> get domainNames => aliases;

  /// Run the Regex provided in CAIP-10
  bool verifyCAIP10Format() {
    bool isChainIdGood = Blockchain.isValidChainId(chainId);
    bool isAccountAddressGood =
        Blockchain.isValidAccountAddress(accountAddress);

    if (isChainIdGood && isAccountAddressGood) {
      return true;
    }
    throw 'Malformed accountId: $accountId ${(isChainIdGood) ? '' : '- chainId has bad format '} ${(isAccountAddressGood) ? '' : '- account address had bad format.'}';
  }

  /// Return string that looks like Polygon 1234...5678
  @override
  String toString() {
    String blockchainName = Blockchain.fromChainId(chainId)?.name ?? 'Unknown';
    return '$blockchainName $accountAddressShort';
  }

  String toFullString() => accountId;

  void addAlias(String alias) {
    if (aliases.contains(alias)) {
      if (kDebugMode) {
        print(
            'BlockchainAccount addAlias: duplicate alias $alias ignored. Redundant lookup?');
        return;
      }
    }
    aliases.add(alias);
  }
}

///  Returns address in EthereumAddress type from web3dart.dart
///  Implemented as an extension if you don't want the web3dart dependency
extension Web3Dart on BlockchainAccount {
  EthereumAddress get toEthereumAddress =>
      EthereumAddress.fromHex(accountAddress);
}
