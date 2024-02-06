import 'package:flutter/material.dart';
import 'package:prioritas1/page/MaterialScreen.dart';
import '../provider/theme_Provider.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> images = [    "images/1.png",    "images/2.png",    "images/3.png",    "images/4.png",    "images/5.png",    "images/6.png",  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.themeData,
            home: Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                     IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text("Gallery"),
                    ]),
                    ElevatedButton(
                      onPressed: () => themeProvider.toggleTheme(),
                      child: Text(themeProvider.mode),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            themeProvider.selectedColor),
                      ),
                    )
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: images.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _showBottomSheet(context, images[index]);
                      },
                      child: Card(
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String image) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Flexible(
                  child: Card(
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text("Ya"),
                    onPressed: () async{
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Lihat Gambar'),
                                content: Flexible(
                                  child: Card(
                                    child: Image.asset(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text('Tidak'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                     Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(image: image),
                                        ),
                                      ).then((value) {
                                        Navigator.pop(context);
                                      }
                                      );
                                    },
                                    child: const Text('Lihat'),
                                  ),
                                ], 
                              ),
                            );
                            Navigator.pop(context);
                          },
 
                  ),
                  ElevatedButton(
                    child: const Text("Tidak"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final String image;

  DetailPage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Center(
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
