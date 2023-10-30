import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



class QRScannerPage extends StatefulWidget {
  final String tableName;

  const QRScannerPage({super.key, required this.tableName});

  @override
  State<StatefulWidget> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {




  final GlobalKey _qrKey = GlobalKey();
  Barcode? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: _qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: _result != null
                  ? Text('QR Kod: ${_result!.code}')
                  : Text(widget.tableName),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _result = scanData;


        addToDatabase(_result!.code!);
        FlutterBeep.beep();

        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            _result = null;
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }




  void addToDatabase(String uid) async {

    if (uid == "null"){
      return ;
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    formatter = new DateFormat('HH:mm:ss');
    String formattedHour = formatter.format(now);

    Map<String, String> data = {
      'time': formattedHour,
    };

    final dbRef = FirebaseFirestore.instance;
    dbRef
        .collection("yemek")
        .doc(formattedDate).collection("employee").doc(uid)
        .set(data)
        .onError((e, _) => print("Error writing document: $e"));
  }


}
