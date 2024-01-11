import 'package:flutter/foundation.dart';

class NativeCurrency {
  final String currencyName;
  final String currencySymbol;
  final int currencyDecimals;

  const NativeCurrency(
      {required this.currencyName,
      required this.currencySymbol,
      required this.currencyDecimals});
}

/// Blockchain helper enumeration based on Chain Agnostic Proposals
///
/// https://github.com/ChainAgnostic/CAIPs/blob/master/README.md
enum Blockchain {
  sepolia(
      name: 'Sepolia Test Network',
      namespace: 'eip155',
      reference: '11155111',
      nativeCurrency: NativeCurrency(
          currencyName: 'SepoliaETH',
          currencySymbol: 'SEPOLIAETH',
          currencyDecimals: 18)),
  ethereum(
      name: 'Ethereum',
      namespace: 'eip155',
      reference: '1',
      nativeCurrency: NativeCurrency(
          currencyName: 'ETH', currencySymbol: 'ETH', currencyDecimals: 18)),
  goerli(
      name: 'Goerli',
      namespace: 'eip155',
      reference: '5',
      nativeCurrency: NativeCurrency(
          currencyName: 'GoerliETH',
          currencySymbol: 'gorETH',
          currencyDecimals: 18)),
  polygon(
      name: 'Polygon',
      namespace: 'eip155',
      reference: '137',
      nativeCurrency: NativeCurrency(
          currencyName: 'MATIC',
          currencySymbol: 'MATIC',
          currencyDecimals: 18)),
  mumbai(
      name: 'Mumbai',
      namespace: 'eip155',
      reference: '80001',
      nativeCurrency: NativeCurrency(
          currencyName: 'TMATIC',
          currencySymbol: 'TMATIC',
          currencyDecimals: 18)),
  scrollSepolia(
      name: 'Scroll Sepolia',
      namespace: 'eip155',
      reference: '534351',
      nativeCurrency: NativeCurrency(
          currencyName: 'ETH', currencySymbol: 'ETH', currencyDecimals: 18)),
  kadena(
      name: 'Kadena',
      namespace: 'kadena',
      reference: 'mainnet:1',
      nativeCurrency: NativeCurrency(
          currencyName: 'KDA', currencySymbol: 'KDA', currencyDecimals: 18));

  const Blockchain(
      {required this.name,
      this.nativeCurrency,
      required this.namespace,
      required this.reference});
  final String name;
  final String reference;
  final String namespace;
  final NativeCurrency?
      nativeCurrency; // Used when adding a new chainId to a wallet

  /// Returns CAIP-2 formatted Blockchain ID
  ///
  /// https://github.com/ChainAgnostic/CAIPs/blob/master/CAIPs/caip-2.md
  String get chainId {
    return '$namespace:$reference';
  }

  /// Returns integer chainId for EIP155 based blockchains
  int get eip155ChainId {
    if (namespace == 'eip155') {
      return int.parse(reference);
    }
    throw 'Unimplemented EIP155 chainId for $name';
  }

  static Set<Blockchain> fromChainIds(List<String>? chainIds) {
    Set<Blockchain> result = {};
    if (chainIds == null) {
      return result;
    }
    for (String chainIdString in chainIds) {
      try {
        Blockchain? blockchain = Blockchain.fromChainId(chainIdString);
        if (blockchain != null) {
          result.add(blockchain);
        }
      } catch (e) {
        if (kDebugMode) {
          // print('Unknown chainId $chainIdString - ignoring. Error: $e');
        }
      }
    }
    return result;
  }

  // In case we have multiword names in the future but code that doesn't like spaces etc
  static const camelCaseNames = {
    Blockchain.sepolia: 'sepolia',
    Blockchain.ethereum: 'ethereum',
    Blockchain.goerli: 'goerli',
    Blockchain.polygon: 'polygon',
    Blockchain.mumbai: 'mumbai',
    Blockchain.scrollSepolia: 'scrollSepolia',
    Blockchain.kadena: 'kadena',
  };

  /// Community provided RPCs are best-effort.  You should consider your own provider (i.e. https://infura.io/)
  static const rpcUrls = {
    Blockchain.sepolia: 'https://sepolia.infura.io/v3/',
    Blockchain.ethereum: 'https://etherscan.io',
    Blockchain.goerli: 'https://rpc.goerli.mudit.blog',
    Blockchain.polygon: 'https://polygon-rpc.com',
    Blockchain.mumbai: 'https://rpc-mumbai.maticvigil.com',
    Blockchain.scrollSepolia: 'https://sepolia-rpc.scroll.io/',
  };

  /// Community provided faucets to get test coin.  You can find multiple options on a web search.
  static const faucetUrls = {
    Blockchain.sepolia: 'https://www.infura.io/faucet/sepolia',
    Blockchain.goerli: 'https://faucet.goerli.mudit.blog',
    // Blockchain.mumbai: 'https://faucet.polygon.technology/',
    Blockchain.mumbai: 'https://mumbaifaucet.com/',
    Blockchain.scrollSepolia: 'https://bwarelabs.com/faucets/scroll-testnet',
    Blockchain.kadena: 'https://faucet.testnet.chainweb.com/',
  };

  /// Official block explorer URLs
  static const blockExplorerUrls = {
    Blockchain.sepolia: 'https://sepolia.etherscan.io/',
    Blockchain.ethereum: 'https://etherscan.io',
    Blockchain.goerli: 'https://goerli.etherscan.io',
    Blockchain.polygon: 'https://polygonscan.com',
    Blockchain.mumbai: 'https://mumbai.polygonscan.com',
    Blockchain.scrollSepolia: 'https://sepolia-blockscout.scroll.io',
    Blockchain.kadena: 'https://explorer.chainweb.com/mainnet'
  };

  /// returns [bool] True if this is a test network / non-production
  bool get isTestnet {
    switch (this) {
      case Blockchain.ethereum:
      case Blockchain.polygon:
        return false;
      case Blockchain.goerli:
      case Blockchain.mumbai:
      case Blockchain.scrollSepolia:
      case Blockchain.sepolia:
        return true;
      default:
        throw 'Unimplemented Blockchain $this';
    }
  }

  bool get isMainnet => !isTestnet;

  /// Provide the recommended testnet for this blockchain
  Blockchain get toTestnet {
    switch (this) {
      case Blockchain.ethereum:
        return Blockchain.goerli;
      case Blockchain.polygon:
        return Blockchain.mumbai;
      case Blockchain.goerli:
      case Blockchain.mumbai:
      case Blockchain.scrollSepolia:
      case Blockchain.sepolia:
        // Do nothing - already a testnet
        return this;
      default:
        throw 'Unimplemented Blockchain $this';
    }
  }

  /// Provide the recommended testnet for this blockchain
  Blockchain get toMainNet {
    switch (this) {
      case Blockchain.goerli:
        return Blockchain.ethereum;
      case Blockchain.mumbai:
        return Blockchain.polygon;
      case Blockchain.ethereum:
      case Blockchain.polygon:
        // Do nothing - already a mainnet
        return this;
      case Blockchain.scrollSepolia:
      case Blockchain.sepolia:
      default:
        throw 'Unimplemented Blockchain $this';
    }
  }

  /// Returns Blockchain from the given early standard integer [int? chainId]
  @Deprecated(
      'EIP155ChainId references should migrate to the CAIP2 standard [chainId] format')
  static Blockchain? fromEip155ChainId(int? value) {
    if (value == null) {
      return null;
    }
    switch (value) {
      case 1:
        return Blockchain.ethereum;
      case 5:
        return Blockchain.goerli;
      case 137:
        return Blockchain.polygon;
      case 80001:
        return Blockchain.mumbai;
      case 534351:
        return Blockchain.scrollSepolia;
      case 11155111:
        return Blockchain.sepolia;
      default:
        throw 'fromChainId - Unimplemented EIP155 ChainId $value';
    }
  }

  /// Returns Blockchain from the given CAIP-2 chainId format
  static Blockchain? fromChainId(String? chainIdString) {
    if (chainIdString == null) {
      return null;
    }
    // Verify it looks like a chainId
    if (isValidChainId(chainIdString)) {
      switch (chainIdString) {
        case 'eip155:1':
          return Blockchain.ethereum;
        case 'eip155:5':
          return Blockchain.goerli;
        case 'eip155:137':
          return Blockchain.polygon;
        case 'eip155:80001':
          return Blockchain.mumbai;
        case 'eip155:534351':
          return Blockchain.scrollSepolia;
        case 'eip155:11155111':
          return Blockchain.sepolia;
        default:
          throw 'fromChainId - Unimplemented chainId $chainIdString';
      }
    } else {
      throw 'fromChainId - Format is not a valid chainId per CAIP-2 standard: $chainIdString';
    }
  }

  String? get camelCaseName => camelCaseNames[this];
  String? get rpcUrl => rpcUrls[this];
  String? get faucetUrl => faucetUrls[this];
  String? get blockExplorerUrl => blockExplorerUrls[this];
  String? get blockExplorerTransactionUrl => '${blockExplorerUrls[this]}/tx';

  /// Verify namespace is CAIP-2 Compliant
  static bool isValidNamespace(String namespace) {
    RegExp namespaceFormat = RegExp(r'[-a-z0-9]{3,8}');
    return namespaceFormat.hasMatch(namespace);
  }

  /// Verify namespace is CAIP-2 Compliant
  static bool isValidReference(String reference) {
    RegExp referenceFormat = RegExp(r'[-_a-zA-Z0-9]{1,32}');
    return referenceFormat.hasMatch(reference);
  }

  /// Verify chainId is CAIP-10 (2) Compliant
  static bool isValidChainId(String chainId) {
    RegExp chainIdFormat = RegExp(r'[-a-z0-9]{3,8}:[-_a-zA-Z0-9]{1,32}');
    return chainIdFormat.hasMatch(chainId);
  }

  /// Verify accountAddress is CAIP-10 Compliant
  static bool isValidAccountAddress(String accountAddress) {
    RegExp accountAddressFormat = RegExp(r'[-.%a-zA-Z0-9]{1,128}');
    return accountAddressFormat.hasMatch(accountAddress);
  }

  @override
  // Prints CAIP2 formatted chainId
  String toString() {
    return chainId;
  }
}

/// The following extensions just made it easier to swap to and from testnets etc
/// You just pick the resource for myblockchain.infuraEndpoint etc

/// RPC API Provider Endpoints for the given blockchain
extension Web3NodeProviderEndpoints on Blockchain {
  // For users to view the NFT's like on rarible.com
  static const web3NodeProviderEndpoints = {
    Blockchain.goerli: 'https://goerli.infura.io/v3',
    Blockchain.ethereum: 'https://mainnet.infura.io/v3',
    Blockchain.polygon: 'https://polygon-mainnet.infura.io/v3',
    Blockchain.mumbai: 'https://polygon-mumbai.infura.io/v3',
    Blockchain.scrollSepolia: 'https://sepolia-rpc.scroll.io/',
    Blockchain.sepolia: 'https://sepolia.infura.io/v3/',
  };
  String? get web3NodeProviderEndpoint => web3NodeProviderEndpoints[this];
}

/// RPC API Provider Endpoints for the given blockchain
extension EIP155RPCMethods on Blockchain {
  // https://ethereum.org/en/developers/docs/apis/json-rpc/
  // https://docs.walletconnect.com/2.0/advanced/rpc-reference/ethereum-rpc
  // https://discord.com/channels/492410046307631105/1052578586395160586/1052578586395160586
  // https://eips.ethereum.org/EIPS/eip-1193#events
  // For users to view the NFT's like on rarible.com
  static const eip155Methods = [
    // 'eth_sign',
    'eth_signTypedData', // Ambiguous suggested to use _v forms
    'personal_sign',
    //'signTypedData_v4',
    'eth_signTransaction',
    // 'eth_sendTransaction',
    // 'eth_sendRawTransaction',
  ];

  List<String> get methods {
    List<String> methods = [];
    switch (namespace) {
      case 'eip155':
        methods = eip155Methods;
        break;
      default:
        throw 'methods unimplemented for $namespace';
    }
    return methods;
  }
}
