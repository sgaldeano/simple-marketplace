import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../decorations/decorations.dart' show InputDecorations;
import '../providers/providers.dart';
import '../validators/validators.dart' show LoginFormValidator;
import '../widgets/widgets.dart' show AuthBackground, FormContainer;
import 'pages.dart' show HomePage;

class LoginPage extends StatelessWidget {

  static const String routeName = 'login_page';

	const LoginPage({super.key});

	@override
	Widget build(BuildContext context) {
  	return Scaffold(
    	body: Center(
      	child: AuthBackground(
					child: SingleChildScrollView(
						child: Column(
							children: [
								const SizedBox(
									height: 250
								),
								FormContainer(
									child: Column(
										children: [
											Text('Login', style: Theme.of(context).textTheme.headlineMedium),

											const SizedBox(height: 16),

											ChangeNotifierProvider(
												create: (_) => LoginFormProvider(),
												child: const _LoginForm()
											)
										],
									)
								),
								const SizedBox(height: 50),
								const Text('Create new account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
								const SizedBox(height: 50)
							],
						)
					)
				)
			),
		);
	}

}

class _LoginForm extends StatelessWidget {

	const _LoginForm({
		super.key,
	});

	@override
	Widget build(BuildContext context) {
		final loginFormProvider = Provider.of<LoginFormProvider>(context);

		return Form(
			key: loginFormProvider.formKey,
			autovalidateMode: AutovalidateMode.onUserInteraction,
			child: Column(
				children: [
					TextFormField(
						autocorrect: false,
						keyboardType: TextInputType.emailAddress,
						decoration: InputDecorations.authInputDecoration(
							labelText: 'Email',
							hintText: 'john.doe@mail.com',
							prefixIcon: Icons.alternate_email_sharp
						),
						onChanged: (value) => loginFormProvider.email = value,
						validator: LoginFormValidator.validateEmail
					),

					const SizedBox(height: 30),

					TextFormField(
						autocorrect: false,
						obscureText: true,
						keyboardType: TextInputType.emailAddress,
						decoration: InputDecorations.authInputDecoration(
							labelText: 'Password',
							hintText: '********',
							prefixIcon: Icons.lock_outline_sharp
						),
						onChanged: (value) => loginFormProvider.password = value,
						validator: LoginFormValidator.validatePassword
					),

					const SizedBox(height: 40),

					MaterialButton(
						height: 50,
						color: Colors.deepPurple,
						disabledColor: Colors.grey,
						elevation: 0,
						shape: RoundedRectangleBorder(
							borderRadius: BorderRadius.circular(20)
						),
						onPressed: !loginFormProvider.isLoading ? () async {
							FocusScope.of(context).unfocus();

							if (loginFormProvider.isValidForm()) {
								loginFormProvider.isLoading = true;

								await Future.delayed(const Duration(seconds: 2));

								loginFormProvider.isLoading = false;

								Navigator.pushReplacementNamed(context, HomePage.routeName);
							}
						} : null,
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
							child: Text(
								!loginFormProvider.isLoading ? 'Enter' : 'Loading...',
								style: const TextStyle(color: Colors.white, fontSize: 16))
						)
					),

					const SizedBox(height: 20)
				]
			)
		);
	}

}