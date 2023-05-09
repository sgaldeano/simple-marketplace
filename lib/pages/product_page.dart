import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:s12_products/widgets/widgets.dart' show ProductImage;
import '../decorations/decorations.dart' show InputDecorations;
import '../models/models.dart' show Product;
import '../providers/providers.dart' show ProductFormProvider;
import '../services/services.dart' show ProductsService;
import '../themes/app_themes.dart';
import '../validators/validators.dart' show ProductFormValidator;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatelessWidget {

	static const String routeName = 'product_page';

	const ProductPage({super.key});

	@override
	Widget build(BuildContext context) {
		final Product product = Provider.of<ProductsService>(context).selectedProduct;

  	return ChangeNotifierProvider(
				create: (_) => ProductFormProvider(product),
				child: const _ProductPageBody()
		);
	}

}

class _ProductPageBody extends StatelessWidget {

	const _ProductPageBody();

  @override
  Widget build(BuildContext context) {
		final ProductsService productsService = Provider.of<ProductsService>(context);

		final ProductFormProvider productFormProvider = Provider.of<ProductFormProvider>(context);
		final Product product = productFormProvider.product;

    return Scaffold(
    	body: SingleChildScrollView(
				child: Column(
					children: [
						Stack(
							children: [
								ProductImage(imagePath: product.imageUrl),

								Positioned(
									top: 40,
									left: 26,
									child: IconButton(
										onPressed: () => Navigator.pop(context),
										icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 30)
									)
								),

								Positioned(
									top: 88,
									right: 26,
									child: IconButton(
										onPressed: () async {
											final ImagePicker imagePicker = ImagePicker();
											final XFile? image = await imagePicker.pickImage(
												source: ImageSource.gallery,
												imageQuality: 100
											);

											if (image != null) {
												productsService.updateSelectedProductImage(image.path);
											}
										},
										icon: const Icon(Icons.image_search_outlined, color: Colors.white, size: 38)
									)
								),

								Positioned(
									top: 38,
									right: 26,
									child: IconButton(
										onPressed: () async {
											final ImagePicker imagePicker = ImagePicker();
											final XFile? image = await imagePicker.pickImage(
												source: ImageSource.camera,
												imageQuality: 100
											);

											if (image != null) {
												productsService.updateSelectedProductImage(image.path);
											}
										},
										icon: const Icon(Icons.photo_camera_outlined, color: Colors.white, size: 35)
									)
								)
							]
						),

						const _ProductDataForm()
					]
				)
			),
			floatingActionButton: FloatingActionButton(
				onPressed: !productsService.isSaving ? () async {
					if (productFormProvider.isValidForm()) {
						await productsService.updateOrCreateProduct();
						Navigator.pop(context);
					}
				} : null,
				child: !productsService.isSaving
					? const Icon(Icons.save, color: Colors.black87)
					: const CircularProgressIndicator(color: Colors.white)
			)
		);
  }
}

class _ProductDataForm extends StatelessWidget {

	const _ProductDataForm();

  @override
  Widget build(BuildContext context) {
		final ProductFormProvider productFormProvider = Provider.of<ProductFormProvider>(context);
		final Product product = productFormProvider.product;

    final formDecoration = BoxDecoration(
			color: Colors.white,
			borderRadius: const BorderRadius.only(
				bottomLeft: Radius.circular(20),
				bottomRight: Radius.circular(20)
			),
			boxShadow: [
				BoxShadow(
						color: Colors.black.withOpacity(0.05),
						blurRadius: 5,
						offset: const Offset(0, 7)
				)
			]
		);

    return Container(
			width: double.infinity,
			margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
			padding: const EdgeInsets.symmetric(horizontal: 20),
			decoration: formDecoration,
			child: Form(
				key: productFormProvider.formKey,
				autovalidateMode: AutovalidateMode.onUserInteraction,
				child: Column(
					children: [
						const SizedBox(height: 20),

						TextFormField(
							initialValue: product.name,
							decoration: InputDecorations.authInputDecoration(
								labelText: 'Name:',
								hintText: 'Product name'
							),
							onChanged: (value) {
								product.name = value;
							},
							validator: (value) => ProductFormValidator.validateMandatoryText(value, 'Product name is mandatory')
						),

						const SizedBox(height: 20),

						TextFormField(
							initialValue: product.price == 0 ? '' : '${product.price}',
							inputFormatters: [
								FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
							],
							keyboardType: const TextInputType.numberWithOptions(decimal: true),
							decoration: InputDecorations.authInputDecoration(
								labelText: 'Price:',
								hintText: '\$150'
							),
							onChanged: (value) {
								double? parsedValue = double.tryParse(value);
								parsedValue != null
									? product.price = parsedValue
									: product.price = 0;
							},
							validator: (value) => ProductFormValidator.validateMandatoryText(value, 'Product price is mandatory')
						),

						const SizedBox(height: 24),

						SwitchListTile(
							title: const Text('Available', style: TextStyle(fontSize: 20)),
							value: product.isAvailable,
							activeColor: AppThemes.primaryColor,
							onChanged: productFormProvider.setProductAvailability
						),

						const SizedBox(height: 30),
					],
				),
			)
		);
  }

}