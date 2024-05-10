import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PageViewParallax extends StatefulWidget {
  PageViewParallax({super.key});

  @override
  State<PageViewParallax> createState() => _PageViewParallaxState();
}

class _PageViewParallaxState extends State<PageViewParallax> {
  List<String> imageUrls = [
    'https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU',
    'https://fastly.picsum.photos/id/7/4728/3168.jpg?hmac=c5B5tfYFM9blHHMhuu4UKmhnbZoJqrzNOP9xjkV4w3o',
    'https://fastly.picsum.photos/id/5/5000/3334.jpg?hmac=R_jZuyT1jbcfBlpKFxAb0Q3lof9oJ0kREaxsYV3MgCc',
    'https://www.gstatic.com/webp/gallery/1.webp',
    'https://fastly.picsum.photos/id/26/4209/2769.jpg?hmac=vcInmowFvPCyKGtV7Vfh7zWcA_Z0kStrPDW3ppP0iGI',
    'https://fastly.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4',
    'https://fastly.picsum.photos/id/25/5000/3333.jpg?hmac=yCz9LeSs-i72Ru0YvvpsoECnCTxZjzGde805gWrAHkM',
  ];

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: pageController,
              builder: (BuildContext context, Widget? child) {
                double pageOffset = 0;
                if (pageController.position.haveDimensions) {
                  pageOffset = pageController.page! - index;
                }
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    alignment: Alignment(pageOffset, 0),
                    fit: BoxFit.fitHeight,
                  ),
                );
              },
            );
          },
          itemCount: imageUrls.length,
        ),
      ),
    );
  }
}
