import 'package:flutter/material.dart';

class Viewphotoscreen extends StatefulWidget {
  const Viewphotoscreen({super.key, required this.imageUrl});

  @override
  State<Viewphotoscreen> createState() => _ViewphotoscreenState();
  final String imageUrl;
}

class _ViewphotoscreenState extends State<Viewphotoscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.white, height: 1),
        ),
        backgroundColor: Color.fromARGB(255, 30, 30, 30),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Image.asset('assets/logo_polarize_white.png', width: 150),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              child: Image.network(
                widget.imageUrl,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(height: 1, width: double.infinity, color: Colors.white),
          Container(
            height: 70,
            decoration: BoxDecoration(color: Color.fromARGB(255, 30, 30, 30)),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.ios_share_outlined,
                    size: 30,
                    color: const Color.fromARGB(255, 233, 233, 233),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_outline,
                    size: 30,
                    color: const Color.fromARGB(255, 233, 233, 233),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
