import 'package:arkan/widgets/Texts.dart';
import 'package:flutter/material.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

class PaymentPage extends StatelessWidget {
  double price ;

  PaymentPage(this.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Confirmation'),
        actions: [
          IconButton(
              icon: Icon(Icons.payment),
              onPressed: () {
                MyFatoorah.startPayment(
                  context: context,
                  errorChild: Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.redAccent,
                      size: 50,
                    ),
                  ),
                  succcessChild: Center(
                    child: Icon(
                      Icons.done_all,
                      color: Colors.greenAccent,
                      size: 50,
                    ),
                  ),
                  request: MyfatoorahRequest.test(
                    token:
                    'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
                    currencyIso: Country.SaudiArabia,
                    successUrl:
                    'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
                    errorUrl:
                    'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
                    invoiceAmount: price,
                    language: ApiLanguage.English,
                  ),
                ).then((response) {
                  print(response);
                }).catchError((e) {
                  print(e);
                });
              })
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return MyFatoorah(
            buildAppBar: (callback) => AppBar(
              title: Texts(title:'Payment Confirmation' ,fSize: 16,),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
            ),
            request: MyfatoorahRequest.test(
              token:
              'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
              currencyIso: Country.Kuwait,
              successUrl:
              'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
              errorUrl:
              'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
              invoiceAmount: 0.1,
              language: ApiLanguage.English,
            ),
            errorChild: Center(
              child: Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 50,
              ),
            ),
            succcessChild: Center(
              child: Icon(
                Icons.done_all,
                color: Colors.greenAccent,
                size: 50,
              ),
            ),
            onResult: (PaymentResponse res) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(res.status.toString()),
              ));
            },
          );
        },
      ),
    );
  }
}
