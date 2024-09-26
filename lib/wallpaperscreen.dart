import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skyscrapper/skyapi.dart';
import 'package:skyscrapper/wallpaperdedetailscreen.dart';

class WallpaperScreen extends StatefulWidget {
   const WallpaperScreen({super.key, required this.imgName});
final String imgName;
  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    Skyapi().loadPostData(widget.imgName.toLowerCase()).then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 33, 61, 1),
      appBar: AppBar(
       iconTheme: const IconThemeData(color: Color(0Xffe0d7d7ff)),
        backgroundColor: const Color.fromRGBO(20, 33, 61, 1),
        title: Text(
          widget.imgName,
          style: const TextStyle(color:Color(0Xffe0d7d7ff), fontWeight: FontWeight.w600),
        ),

      ),
      body: Center(
        child: isLoading == true
            ? const CircularProgressIndicator()
            : SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: GridView.custom(
                    gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: [
                          const QuiltedGridTile(2, 2),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(2, 1),
                          const QuiltedGridTile(1, 2),
                        ]),
                    childrenDelegate: SliverChildBuilderDelegate(
                        childCount: histList.length,
                        (context, index) => InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WallpaperDetailScreen(wall: histList[index].largeImageUrl!,)));
                          },
                          child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            histList[index].largeImageUrl!))),
                              ),
                        )))
                /*GridView.builder(
                  itemCount: histList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WallpaperDetailScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(25),

                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      histList[index]!.largeImageUrl!))),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      childAspectRatio: 3 / 5,
                      crossAxisSpacing: 0),
                ),*/
                ),
      ),
    );
  }
}
