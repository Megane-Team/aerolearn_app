import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';

class SertifikatKatalog extends StatefulWidget {
  const SertifikatKatalog({super.key});

  @override
  State<SertifikatKatalog> createState() => _SertifikatKatalogState();
}

class _SertifikatKatalogState extends State<SertifikatKatalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Image.asset(Assets.icons('arrow_back')),
                onPressed: () {
                  //action
                },
            ),
            Expanded(
                child: Text(
                    'Tes123'
                ),
            )
          ],
        ),
      ),
    );
  }
}
