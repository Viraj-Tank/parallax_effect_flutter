import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListViewParallax extends StatelessWidget {
  List<String> imageUrls = [
    'https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU',
    'https://fastly.picsum.photos/id/7/4728/3168.jpg?hmac=c5B5tfYFM9blHHMhuu4UKmhnbZoJqrzNOP9xjkV4w3o',
    'https://fastly.picsum.photos/id/5/5000/3334.jpg?hmac=R_jZuyT1jbcfBlpKFxAb0Q3lof9oJ0kREaxsYV3MgCc',
    'https://www.gstatic.com/webp/gallery/1.webp',
    'https://fastly.picsum.photos/id/26/4209/2769.jpg?hmac=vcInmowFvPCyKGtV7Vfh7zWcA_Z0kStrPDW3ppP0iGI',
    'https://fastly.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4',
    'https://fastly.picsum.photos/id/25/5000/3333.jpg?hmac=yCz9LeSs-i72Ru0YvvpsoECnCTxZjzGde805gWrAHkM',
    'https://fastly.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68',
    'https://fastly.picsum.photos/id/7/4728/3168.jpg?hmac=c5B5tfYFM9blHHMhuu4UKmhnbZoJqrzNOP9xjkV4w3o',
    'https://fastly.picsum.photos/id/20/3670/2462.jpg?hmac=CmQ0ln-k5ZqkdtLvVO23LjVAEabZQx2wOaT4pyeG10I',
    'https://fastly.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s',
    'https://fastly.picsum.photos/id/7/4728/3168.jpg?hmac=c5B5tfYFM9blHHMhuu4UKmhnbZoJqrzNOP9xjkV4w3o',
    'https://fastly.picsum.photos/id/5/5000/3334.jpg?hmac=R_jZuyT1jbcfBlpKFxAb0Q3lof9oJ0kREaxsYV3MgCc',
    'https://www.gstatic.com/webp/gallery/2.webp',
    'https://fastly.picsum.photos/id/26/4209/2769.jpg?hmac=vcInmowFvPCyKGtV7Vfh7zWcA_Z0kStrPDW3ppP0iGI',
  ];

  ListViewParallax({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListItem(
        imageUrls: imageUrls,
        index: index,
      ),
      itemCount: 15,
    );
  }
}

class ListItem extends StatelessWidget {
  final int index;
  final List<String> imageUrls;

  ListItem({
    super.key,
    required this.imageUrls,
    required this.index,
  });

  final keyImage = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      height: 150,
      child: Flow(
        delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context),
          itemContext: context,
          keyImage: keyImage,
        ),
        children: [
          CachedNetworkImage(
            imageUrl: imageUrls[index],
            key: keyImage,
            fit: BoxFit.cover,
            placeholder: (_, __) => const Center(child: Icon(Icons.image)),
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ScrollableState scrollable;
  BuildContext itemContext;
  GlobalKey keyImage;

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.itemContext,
    required this.keyImage,
  }) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) => BoxConstraints.tightFor(
        width: constraints.maxWidth,
      );

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final itemBox = itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(itemBox.size.centerLeft(Offset.zero), ancestor: scrollableBox);
    final viewPortDimension = scrollable.position.viewportDimension;
    final scrollFraction = (itemOffset.dy / viewPortDimension).clamp(0, 1);

    final verticalAlignment = Alignment(0, scrollFraction * 2 - 1);

    final imageBox = keyImage.currentContext?.findRenderObject() as RenderBox;
    final childRect = verticalAlignment.inscribe(
      imageBox.size,
      Offset.zero & context.size,
    );
    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(covariant ParallaxFlowDelegate oldDelegate) => scrollable != oldDelegate.scrollable || itemContext != oldDelegate.itemContext || keyImage != oldDelegate.keyImage;
}
