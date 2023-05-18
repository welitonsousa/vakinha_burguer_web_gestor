import 'dart:html';

import 'package:dw10/src/core/helpers/formatters.dart';
import 'package:dw10/src/core/helpers/upload_file.dart';
import 'package:dw10/src/core/ui/helpers/loader.dart';
import 'package:dw10/src/core/ui/helpers/message.dart';
import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/models/product_model.dart';
import 'package:dw10/src/modules/products/product_detail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask/mask.dart';
import 'package:mobx/mobx.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with Loader, Message {
  int? productID = int.tryParse(Modular.args.queryParams['id'] ?? '');

  final name = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final form = GlobalKey<FormState>();
  final fileInput = UploadFile();
  final controller = Modular.get<ProductDetailController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reaction((_) => controller.status, (status) {
        switch (status) {
          case ProductDetailState.initial:
            break;
          case ProductDetailState.loading:
            showLoader();
            break;
          case ProductDetailState.success:
            hideLoader();
            break;
          case ProductDetailState.error:
            hideLoader();
            showMessage(controller.message, type: MessageType.failure);
            break;
        }
      });

      findProduct();
    });
    super.initState();
  }

  Future<void> findProduct() async {
    if (productID != null) {
      final product = await controller.findProduct(productID!);
      if (product != null) {
        name.text = product.name;
        price.text = Format.moneyDisplay(product.price);
        description.text = product.description;
      }
    }
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 100),
              Text(
                '${productID != null ? "Alterar" : "Criar"} produto',
                style: context.textTheme.titleLarge,
              ),
              IconButton(
                onPressed: window.history.back,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: Stack(
                          children: [
                            Observer(builder: (context) {
                              return Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                    image: controller.image != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                MemoryImage(controller.image!))
                                        : controller.urlImage.isNotEmpty
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  controller.urlImage,
                                                ))
                                            : null),
                              );
                            }),
                            Align(
                              alignment: Alignment.center,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white.withOpacity(.5))),
                                onPressed: () {
                                  fileInput.selectFile((file, name) {
                                    controller.selectFile(file);
                                  });
                                },
                                child: const Text('Alterar'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.red,
                            ),
                            TextFormField(
                              controller: name,
                              validator: Mask.validations.generic,
                              decoration:
                                  const InputDecoration(labelText: "Nome"),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: price,
                              inputFormatters: [
                                Mask.money(),
                              ],
                              validator: (v) =>
                                  Mask.validations.money(v, min: 1),
                              decoration:
                                  const InputDecoration(labelText: "Preço"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    minLines: 4,
                    maxLines: 5,
                    controller: description,
                    validator: Mask.validations.generic,
                    decoration: const InputDecoration(
                      labelText: "Descrição",
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (productID != null)
                        OutlinedButton(
                          onPressed: () {
                            controller.delete(productID!);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  context.theme.colorScheme.error)),
                          child: const Text(
                            'Deletar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () async {
                          if (form.currentState!.validate()) {
                            await controller.save(
                              ProductModel(
                                id: productID,
                                name: name.text,
                                description: description.text,
                                price: Format.moneyToDouble(price.text),
                                enabled: true,
                              ),
                            );
                            window.history.back();
                          }
                        },
                        child: const Text('Salvar'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
