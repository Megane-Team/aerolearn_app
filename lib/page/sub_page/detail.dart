import 'package:flutter/material.dart';
import 'package:aerolearn/utils/asset.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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
                  'Rincian Pelatihan',
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
          children: const [
            RincianTraining(
              koordinator: 'Bruce wayne',
              training: 'Aircraft Basic Training',
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ligula aliquet vulputate consequat class sed tellus eget dictumst ultrices libero. Eget cras sociosqu justo phasellus interdum dictum potenti enim dictumst convallis sem semper fusce hendrerit\nScelerisque vitae orci vehicula platea ligula condimentum massa sagittis. Varius sodales fusce sit fringilla vel volutpat quis. Venenatis iaculis ligula sodales eleifend aptent et proin euismod laoreet conubia class.\nVenenatis aliquet pulvinar facilisis pellentesque enim laoreet nunc litora mi proin porttitor rhoncus. Scelerisque nibh dolor erat suspendisse ad nunc semper cras ac urna integer porta. Nostra porta sit ultricies faucibus suspendisse lectus mauris ligula elementum semper etiam platea gravida donec. Mauris potenti euismod semper fermentum ornare sit. Rutrum rhoncus curae leo potenti mauris dui vulputate mauris sagittis nibh lobortis eu praesent lobortis.',
            ),
          ],
        ),
      ),
    );
  }
}

class RincianTraining extends StatelessWidget {
  final String koordinator;
  final String training;
  final String description;

  const RincianTraining({
    super.key,
    required this.koordinator,
    required this.training,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Expanded(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    border: Border(
                      top: BorderSide(color: Color(0xFF898989)),
                      left: BorderSide(color: Color(0xFF898989)),
                      right: BorderSide(color: Color(0xFF898989)),
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 22, left: 18),
                        child: Text(
                          training,
                          style: TextStyle(
                              color: Color(0xFF1D5C96),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 18),
                        child: Text(
                          koordinator,
                          style: TextStyle(
                              color: Color(0xFF1D5C96),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.92,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF898989)),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: [Text(description)],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> rincian = [
  {
    'instruktur': 'ALI YUSRI',
    'training': 'Aircraft Basic Training',
    'description': 'ini deskripsi',
  },
];
