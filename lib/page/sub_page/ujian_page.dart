import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';

class UjianPage extends StatefulWidget {
  const UjianPage({super.key});

  @override
  State<UjianPage> createState() => _UjianPageState();
}

class _UjianPageState extends State<UjianPage> {
  int _groupValue = 0;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _groupValue = value ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset(Assets.icons('arrow_back')),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Ujian',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            SizedBox(width: 48),
          ],
        ),
        backgroundColor: Color(0xff12395D),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 1),
        child: ListView(
          children: [
            Ujian(
              nomorPertanyaan: 'Bruce wayne',
              pertanyaan:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ligula aliquet vulputate consequat class sed tellus eget dictumst ultrices libero. Eget cras sociosqu justo phasellus interdum dictum potenti enim dictumst convallis sem semper fusce hendrerit\nScelerisque vitae orci vehicula platea ligula condimentum massa sagittis. Varius sodales fusce sit fringilla vel volutpat quis. Venenatis iaculis ligula sodales eleifend aptent et proin euismod laoreet conubia class.\nVenenatis aliquet pulvinar facilisis pellentesque enim laoreet nunc litora mi proin porttitor rhoncus. Scelerisque nibh dolor erat suspendisse ad nunc semper cras ac urna integer porta. Nostra porta sit ultricies faucibus suspendisse lectus mauris ligula elementum semper etiam platea gravida donec. Mauris potenti euismod semper fermentum ornare sit. Rutrum rhoncus curae leo potenti mauris dui vulputate mauris sagittis nibh lobortis eu praesent lobortis.',
              pilihan: [
                'pilihan 1',
                'pilihan 2',
                'pilihan 3',
                'pilihan 4',
                'pilihan 5',
              ],
              groupValue: _groupValue,
              onChanged: _handleRadioValueChange,
            ),
          ],
        ),
      ),
    );
  }
}

class Ujian extends StatelessWidget {
  final String nomorPertanyaan;
  final String pertanyaan;
  final List<String> pilihan;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  const Ujian({
    super.key,
    required this.nomorPertanyaan,
    required this.pertanyaan,
    required this.pilihan,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(
          child: Text('Pertanyaan 1 dari 10'),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.92,
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pertanyaan),
              ],
            ),
          ),
        ),
        SizedBox(height: 35),
        SafeArea(
            child: Column(
          children: pilihan
              .asMap()
              .entries
              .map(
                (entry) => ListTile(
                  title: Text(entry.value),
                  leading: Radio(
                    value: entry.key,
                    groupValue: groupValue,
                    onChanged: onChanged,
                  ),
                ),
              )
              .toList(),
        ))
      ],
    );
  }
}
