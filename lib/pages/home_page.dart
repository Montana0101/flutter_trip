import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROOL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  double appBarAlpha = 0;
  final _imgList = [
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.bbra.cn%2F%28S%283alyer55do3dzk45dg3ugday%29%29%2FUploadfiles%2Fimgs%2F2014%2F03%2F13%2Ffeng1%2FXbzs_010.jpg&refer=http%3A%2F%2Fwww.bbra.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1628085753&t=1f6c85356286451b5d551130a8ceaf6a',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Ff.01ny.cn%2Fforum%2F201209%2F24%2F18542423ev9tt321qznk93.jpg&refer=http%3A%2F%2Ff.01ny.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1628085754&t=7d2224c442df744f3d389eb58b74a6bc',
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.33lc.com%2Farticle%2FUploadPic%2F2012-8%2F201283858413184.jpg&refer=http%3A%2F%2Fwww.33lc.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1628085754&t=910e2c7b1fb27796f70c1d88048b36d6'
  ];
  _onScroll(offset) {
    print(offset);
    double alpha = offset / APPBAR_SCROOL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha=alpha;
    });
    print(appBarAlpha);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Center(
                child: NotificationListener(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        // 滚动且是列表滚动的时候
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                    },
                    child: ListView(
                      children: [
                        Container(
                            height: 160,
                            child: Swiper(
                              itemCount: _imgList.length,
                              autoplay: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Image.network(_imgList[index],
                                    fit: BoxFit.fill);
                              },
                              pagination: SwiperPagination(),
                            )),
                        Container(
                          height: 800,
                          child: Text('dsa'),
                        )
                      ],
                    )))),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child:
                  Padding(padding: EdgeInsets.only(top: 20), child: Text('首页')),
            ),
          ),
        )
      ],
    ));
  }
}
