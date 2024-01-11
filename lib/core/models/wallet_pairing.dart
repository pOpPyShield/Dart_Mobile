import 'explorer_registry_listing.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_paring.g.dart';

/// WalletConnect Pairing is on top of the Relay Protocol.  The pairing session is longer lived
/// and supports multiple protocols running over the pairint (e.g. Sign,Auth,Chat,Push)
/// https://docs.walletconnect.com/2.0/specs/clients/core/pairing/

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class WalletPairingInfo {
  WalletPairingInfo(
      {required this.pairingTopic, this.wcUri, this.registryListing});

  String pairingTopic;
  String? currentSessionTopic;
  Uri? wcUri;
  ExplorerRegistryListing?
      registryListing; // Details on the wallet we connected to
  int sessionCount = 0; // number of sessions associated with pairing

  // Really need a log event with timestamp etc, but aggregate buckets are useful too
  Map<String, int> errorMessageCount = {};

  //  Sign Protocol Stats (aggregate across all sign sessions for this pairing)
  List<String> signTransactionHashes = [];
  int signTransactionCount = 0;

  // Auth Protocol Stats

  // Chat Protocol Stats

  factory WalletPairingInfo.fromJson(Map<String, dynamic> json) =>
      _$WalletPairingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletPairingInfoToJson(this);
}

class WalletState {}
