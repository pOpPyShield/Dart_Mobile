import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/core/models/blockchain_account.dart';
import 'package:volunteerapp/core/models/volunteerActivity.dart';
import 'package:volunteerapp/core/models/wallet_connect_eip155_credential.dart';
import 'package:volunteerapp/core/models/wallet_connect_extensions.dart';
import 'package:volunteerapp/widgets/app_bar/appbar_leading_image.dart';
import 'package:volunteerapp/widgets/app_bar/appbar_title.dart';
import 'package:volunteerapp/widgets/app_bar/custom_app_bar.dart';
import 'package:volunteerapp/widgets/custom_elevated_button.dart';
import 'package:volunteerapp/widgets/custom_radio_button.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:walletconnect_secure_storage/walletconnect_secure_storage.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:logger/logger.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:eth_sig_util/model/typed_data.dart';
import './constant.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';
import 'dart:io';
import 'package:volunteerapp/core/models/blockchain.dart';
import 'dart:math';

class PaymethodScreen extends StatefulWidget {
  final VolunteerActivity activity;

  PaymethodScreen({Key? key, required this.activity}) : super(key: key);

  @override
  _PaymethodScreenState createState() => _PaymethodScreenState();
}

late WalletConnect walletConnect;
var logger = Logger(printer: SimpleLogPrinter(''));
late String minter;
late int chainId;
late BlockchainFlavor blockchainFlavor;

class SimpleLogPrinter extends LogPrinter {
  final String className;
  SimpleLogPrinter(this.className);
  @override
  List<String> log(LogEvent event) {
    DateTime dateTime = DateTime.now();
    //var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    return ['${dateTime.toUtc()} $emoji $className - ${event.message}'];
    //println(color('$emoji $className - ${event.message}'));
  }
}

class _PaymethodScreenState extends State<PaymethodScreen> {
  TextEditingController _controller = TextEditingController();
  String statusMessage = 'Initialized';
  String radioGroup = "";
  Web3App? web3app;
  Web3Wallet? web3wallet;
  SessionData? session;
  Uri? uri;
  String? url;
  String? account;
  //TODO, NOTE: different for iOS?
  final String deepLink = "metamask://wc?uri=";
  Future<void> initWalletConnect() async {
    // Wallet Connect Session Storage - So we can persist connections
    final sessionStorage = WalletConnectSecureStorage();
    final session = await sessionStorage.getSession();

    // Create a connector
    walletConnect =
        //WalletConnect();
        WalletConnect(
      // TODO: V1 performance issues - consider rolling your own bridge
      /*bridge:
          'https://amazon.com',*/ // causing error: 'https://bridge.walletconnect.org',
      bridge: 'wss://relay.walletconnect.com',
      session: session,
      sessionStorage: sessionStorage,
      clientMeta: PeerMeta(
        name: 'Flutter Rarible Demo',
        description: 'Flutter Rarible Protocol Demo App',
        url: 'https://www.rarible.org',
        icons: [],
      ),
    );

    // Did we restore a session?
    if (session != null) {
      logger.d(
          "WalletConnect - Restored  v${session.version} session: ${session.accounts.length} account(s), bridge: ${session.bridge} connected: ${session.connected}, clientId: ${session.clientId}");

      if (session.connected) {
        logger.d(
            'WalletConnect - Attempting to reuse existing connection for chainId ${session.chainId} and wallet address ${session.accounts[0]}.');
        setState(() {
          minter = session.accounts[0];
          chainId = session.chainId;
          blockchainFlavor = BlockchainFlavorExtention.fromChainId(chainId);
        });
      }
    } else {
      logger.w(
          'WalletConnect - No existing sessions.  User needs to connect to a wallet.');
    }

    walletConnect.registerListeners(
      onConnect: (status) {
        // Status is updated, but session.peerinfo is not yet available.
        logger.d(
            'WalletConnect - onConnect - Established connection with  Wallet app: ${walletConnect.session.peerMeta?.name} -${walletConnect.session.peerMeta?.description}');

        setState(() {
          statusMessage =
              'WalletConnect session established with ${walletConnect.session.peerMeta?.name} - ${walletConnect.session.peerMeta?.description}.';
        });

        // Did the user select a new chain?
        if (chainId != status.chainId) {
          logger.d(
              'WalletConnect - onConnect - Selected blockchain has changed: chainId: $chainId <- ${status.chainId})');
          setState(() {
            chainId = status.chainId;
            blockchainFlavor = BlockchainFlavorExtention.fromChainId(chainId);
          });
        }

        // Did the user select a new wallet address?
        if (minter != status.accounts[0]) {
          logger.d(
              'WalletConnect - onConnect - Selected wallet has changed: minter: $minter <- ${status.accounts[0]}');
          setState(() {
            minter = status.accounts[0];
          });
        }
      },
      onSessionUpdate: (status) {
        // What information is available?
        //print('WalletConnect - Updated session. $status');

        logger.d(
            'WalletConnect - onSessionUpdate - Wallet ${walletConnect.session.peerMeta?.name} - ${walletConnect.session.peerMeta?.description}');

        setState(() {
          statusMessage =
              'WalletConnect - SessionUpdate received with chainId ${status.chainId} and account ${status.accounts[0]}.';
        });

        // Did the user select a new chain?
        if (chainId != status.chainId) {
          logger.d(
              'WalletConnect - onSessionUpdate - Selected blockchain has changed: chainId: $chainId <- ${status.chainId}');
          setState(() {
            chainId = status.chainId;
            blockchainFlavor = BlockchainFlavorExtention.fromChainId(chainId);
          });
        }

        // Did the user select a new wallet address?
        if (minter != status.accounts[0]) {
          logger.d(
              'WalletConnect - onSessionUpdate - Selected wallet has changed: minter: $minter <- ${status.accounts[0]}');
          setState(() {
            minter = status.accounts[0];
          });
        }
      },
      onDisconnect: () async {
        logger.d(
            'WalletConnect - onDisconnect - minter: $minter <- "Please Connect Wallet"');
        setState(() {
          minter = 'Please Connect Wallet';
          statusMessage = 'WalletConnect session disconnected.';
        });
        await initWalletConnect();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Future<void> createWalletConnectV2Instance() async {
    try {
      print("initializing web3app instance...");
      web3app = await Web3App.createInstance(
        relayUrl:
            'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
        projectId: 'bea7091830bf94f067ad8afbcf921b71',
        metadata: PairingMetadata(
          name: 'Wallet (Responder)',
          description: 'A wallet that can be requested to sign transactions',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );

      /*
      web3wallet = await Web3Wallet.createInstance(
        relayUrl:
            'wss://relay.walletconnect.com', // The relay websocket URL, leave blank to use the default
        projectId: 'bea7091830bf94f067ad8afbcf921b71',
        metadata: PairingMetadata(
          name: 'Wallet (Responder)',
          description: 'A wallet that can be requested to sign transactions',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
      */
      print("initialized");
      //Register event handlers
      print("initializing register event handlers...");
      //List<BlockchainAccount>? blockchainAccounts = namespacesToBlockchainAccounts(session!.namespaces);;
      web3app!.onSessionPing.subscribe((args) {
        print("[$runtimeType] _onSessionPing $args");
      });
      web3app!.onSessionConnect.subscribe((args) {
        print("[$runtimeType] _onSessionConnect $args");
      });
      web3app!.onSessionEvent.subscribe((args) {
        print("[$runtimeType] _onSessionEvent $args");
      });
      web3app!.onSessionUpdate.subscribe((args) {
        print("[$runtimeType] _onSessionUpdate $args");
      });
    } catch (err, stackTrace) {
      print("catch err $stackTrace");
    }
  }

  Uri? formatNativeUrl(String? deepLink, String wcUri) {
    String safeAppUrl = deepLink ?? "";

    if (deepLink != null && deepLink.isNotEmpty) {
      if (!safeAppUrl.contains('://')) {
        safeAppUrl = deepLink.replaceAll('/', '').replaceAll(':', '');
        safeAppUrl = '$safeAppUrl://';
      }
    }

    String encodedWcUrl = Uri.encodeComponent(wcUri);
    print('Encoded WC URL: $encodedWcUrl');

    return Uri.parse('$safeAppUrl$encodedWcUrl');
  }

  Future<void> saveJsonToFile(List<dynamic> jsonData, String filePath) async {
    final file = File(filePath);
    final encodedJson = JsonEncoder.withIndent('  ').convert(jsonData);

    await file.writeAsString(encodedJson);
  }

  Future<void> callSmartContractFunction(String abi) async {
    // Ethereum node URL
    final String rpcUrl =
        'https://mainnet.infura.io/v3/your_infura_project_id'; // Replace with your Infura project ID or your Ethereum node URL

    // Smart contract address and ABI
    final String contractAddress = widget.activity.contract
        .contractAddress; // Replace with your smart contract address

    // Create an Ethereum HTTP client
    //final Client httpClient = Client();
    final EthereumAddress contractAddr =
        EthereumAddress.fromHex(contractAddress);

    // Connect to the Ethereum node
    //final Web3Client ethClient = Web3Client(rpcUrl, httpClient);

    // Create a contract instance
    final contract = DeployedContract(
      ContractAbi.fromJson(abi, 'Fund'), // Replace with your contract name
      contractAddr,
    );

    // Call the smart contract function
    //final injectedInstance =
    //ethClient.sendTransaction(cred, transaction)
    //final EthereumAddress caller = await ethClient.credentials.extractAddress();
    //final List<dynamic> result = await ethClient.call(
    //  contract: contract,
    //  function: contract.function('fund'), // Replace with your function name
    //  params: [],
    //  from: caller,
    //);

    //print('Smart contract function result: $result');

    // Close the Ethereum client
    //httpClient.close();
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("lib/core/abi.json");
    String contractAddress = widget.activity.contract.contractAddress;
    final contract = DeployedContract(ContractAbi.fromJson(abi, "Fund"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunc = contract.function(functionName);
    Client httpClient = Client();
    Web3Client web3Client = Web3Client(
        "https://sepolia.infura.io/v3/1d5011de4ef34eec951bc1c2b5298506",
        httpClient);
    final result = await web3Client.call(
        contract: contract, function: ethFunc, params: args);
    return result;
  }

  Future<void> getBalance(String targetAddress) async {}
  Future<String> submit(String functionName, List<dynamic> args) async {
    Blockchain? blockChain = Blockchain.fromChainId("eip155:11155111");
    WalletConnectEip155Credentials connectEip155Credentials =
        WalletConnectEip155Credentials(
            signEngine: web3app!.signEngine,
            sessionTopic: session!.topic,
            blockchain: blockChain!,
            credentialAddress: EthereumAddress.fromHex(account!));
    DeployedContract contract = await loadContract();
    Client httpClient = Client();
    final ethFunc = contract.function(functionName);
    Web3Client web3Client = Web3Client(
        "https://sepolia.infura.io/v3/1d5011de4ef34eec951bc1c2b5298506",
        httpClient);
    final result = await web3Client.sendTransaction(
        connectEip155Credentials,
        Transaction.callContract(
            contract: contract,
            function: ethFunc,
            parameters: args,
            maxGas: 100000),
        chainId: 11155111);
    return result;
  }

  Future<void> donate() async {
    num myAmount = 50 * pow(10, 18);
    print(myAmount);
    //return await submit("fund", []);
    return;
  }

  Future<void> getSmartContract(BuildContext context) async {
    print(widget.activity.contract.contractAddress);
    final urlGen = 'https://api-sepolia.etherscan.io/api?';
    final module = 'module=contract';
    final action = 'action=getabi';
    final address = 'address=' + widget.activity.contract.contractAddress;
    final apikey = 'apikey=BYCX8VM8PX9GCY6U1XAJGYQ9ZWIBPNC7YE';
    print(urlGen + '&' + module + '&' + action + '&' + address + '&' + apikey);
    final urlFinal = Uri.parse(
        urlGen + '&' + module + '&' + action + '&' + address + '&' + apikey);
    try {
      // Make the HTTP request
      final response = await Client().get(urlFinal);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the JSON data
        final jsonData = json.decode(response.body);
        //final resultData = json.decode(jsonData['result']);
        // Save the JSON data to a .json file
        String stringAbi = jsonData['result'].replaceAll(r'\', '');
        await saveJsonToFile(stringAbi as List, '../../core/abi.json');

        print('JSON data saved $stringAbi');
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  loginUsingMetamask(BuildContext context) async {
    if (web3app == null) await createWalletConnectV2Instance();

    try {
      //TODO, CHECK: pop-up takes too long to appear
      ConnectResponse? resp = await web3app?.connect(requiredNamespaces: {
        'eip155': const RequiredNamespace(
          chains: ["eip155:11155111"], // sepolia chain
          methods: [
            'personal_sign',
            'eth_sign',
            'eth_sendTransaction',
            'eth_signTypedData',
          ], // Requestable Methods
          events: ["chainChanged", "accountsChanged"], // Requestable Events
        )
      });
      uri = resp?.uri;
      url = uri.toString();
      if (deepLink != null) {
        final link = formatNativeUrl("metamask://wc?uri=", uri.toString());
        url = link.toString();
      }
      print(url);

      //if (await canLaunchUrlString(url.toString())) {
      await launchUrlString(url.toString(),
          mode: LaunchMode
              .externalApplication /*LaunchMode.externalNonBrowserApplication*/);
      print("returning the wallet response $url");
      //ses = (await resp?.session.future);
      session = (await resp?.session.future);
      print("SessionData ----> ${session.toString()}");

      final String address = NamespaceUtils.getAccount(
        session?.namespaces.values.first.accounts.first ?? "",
      );

      // if (resp.session.isCompleted) {
      print("calling onConnected function :- ${resp?.session.isCompleted}");
      print("---> $address");
      account = address;

      // onConnected != null ? onConnected() : () {};
      // }
    } catch (err, s) {
      print("error connecting wallet -----> $err, $s");
    }
  }

  Future<void> createWalletConnectSession(BuildContext context) async {
    // Create a new session
    //if (walletConnect.connected) {
    if (session != null) {
      //<String, SessionData>
      final String web3appStatus = web3app!.getActiveSessions().toString();
      print("Web3app value: $web3appStatus");
      return;
    }
    /** 
    if(web3app?.getActiveSessions()) {
      statusMessage =
          'Already connected to ${walletConnect.session.peerMeta?.name} \n${walletConnect.session.peerMeta?.description}\n${walletConnect.session.peerMeta?.url}';
      logger.d(
          'createWalletConnectSession - WalletConnect Already connected to ${walletConnect.session.peerMeta?.name} with minter: $minter, chainId $chainId. Ignored.');
      return;
    }
    logger.d('createWalletConnectSession');
    */
    //SessionStatus session;
    //SessionData? session;
    try {
      loginUsingMetamask(context);
    } catch (e) {
      logger.e('Unable to connect - killing the session on our side.');
      statusMessage = 'Unable to connect - killing the session on our side.';
      walletConnect.killSession();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  decoration: AppDecoration.fillWhiteA.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderBL48,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAppBar(context),
                        SizedBox(height: 36.v),
                        _buildBuildTomorrowSection(context),
                        SizedBox(height: 40.v),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'Enter the amount',
                            prefixText: '\$ ',
                            hintText: '0.00',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 40.v),
                        _buildPaymentMethodSection(context),
                        SizedBox(height: 32.v),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildDonateButton(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 25.v,
      leadingWidth: 23.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgVectorBlack900,
        margin: EdgeInsets.only(left: 16.h, top: 7.v, bottom: 5.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Donate"),
    );
  }

  Widget _buildBuildTomorrowSection(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: widget.activity.image,
            height: 76.v,
            width: 120.h,
            radius: BorderRadius.circular(8.h),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11.h, bottom: 19.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 232.h,
                  child: Text(
                    widget.activity.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                SizedBox(height: 8.v),
                Text(
                  "By: HT Organization",
                  style: CustomTextStyles.labelLargeGray400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Payment Method"),
        SizedBox(height: 32.v),
        _buildPaymentOption("Credit Card", ImageConstant.imgImage3328x62),
        _buildPaymentOption("Bank Transfer", ImageConstant.imgImage34),
        _buildPaymentOption("PayPal", ImageConstant.imgImage35),
        _buildCryptocurrencyOption(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 6.h),
      child: Text(
        title,
        style: CustomTextStyles.titleLargeBlack900,
      ),
    );
  }

  Widget _buildPaymentOption(String label, String imagePath) {
    return Padding(
      padding: EdgeInsets.only(left: 6.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h, right: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgContrast,
                  height: 22.v,
                  width: 20.h,
                  margin: EdgeInsets.symmetric(vertical: 3.v),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h, top: 4.v, bottom: 3.v),
                  child: Text(
                    label,
                    style: CustomTextStyles.titleMediumInterPrimary,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: imagePath,
                  height: 28.v,
                  width: 62.h,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.v),
        ],
      ),
    );
  }

  Widget _buildCryptocurrencyOption() {
    return Padding(
      padding: EdgeInsets.only(left: 10.h, right: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18.v),
            child: CustomRadioButton(
              text: "Cryptocurrency",
              value: "Cryptocurrency",
              groupValue: radioGroup,
              onChange: (value) {
                radioGroup = value;
              },
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage36,
            height: 42.adaptSize,
            width: 42.adaptSize,
          ),
        ],
      ),
    );
  }

  Widget _buildDonateButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Donate",
      //onPressed: () => loginUsingMetamask(context, session),
      //onPressed: () => getSmartContract(context),
      //onPressed: () => createWalletConnectSession(context),
      onPressed: () => donate(),
      margin: EdgeInsets.only(
        top: 6.h,
        left: 16.h,
        right: 16.h,
        bottom: 16.v,
      ),
      buttonStyle: CustomButtonStyles.fillLightGreenTL8,
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
