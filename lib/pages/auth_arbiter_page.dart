import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart' show AuthService;
import 'pages.dart';

class AuthArbiterPage extends StatelessWidget {

  static const String routeName = 'check_auth_page';

	const AuthArbiterPage({super.key});

	@override
	Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

  	return Scaffold(
  	  body: Center(
  	    child: FutureBuilder(
          future: authService.getAuthToken(),
          builder: (_, AsyncSnapshot<String> snapshot) {

            if (!snapshot.hasData) {
              return const Text('');
            }

            Future.microtask(() {
                if (snapshot.data != '') {
                  Navigator.pushReplacement(context, PageRouteBuilder(
                      pageBuilder: (_,__,___) => const HomePage(),
                      transitionDuration: const Duration(seconds: 0)
                    )
                  );
                } else {
                  Navigator.pushReplacement(context, PageRouteBuilder(
                      pageBuilder: (_,__,___) => const LoginPage(),
                      transitionDuration: const Duration(seconds: 0)
                    )
                  );
                }
              }
            );

            return const SizedBox();
          },
        ),
  	  ),
  	);

    // return FutureBuilder(
    //   future: authService.getAuthToken(),
    //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //     if (snapshot.data != '') {
    //       return const HomePage();
    //     }
    //
    //     return const LoginPage();
    //   },
    // );
	}

}