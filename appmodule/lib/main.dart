import 'dart:ui';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

import 'Classes/Music.dart';

void main()=>runApp(new MaterialApp(
   home: Index(),
   debugShowCheckedModeBanner: false,
));

class Index extends StatefulWidget{
     Template createState()=>  Template();
}

class Template extends State<Index>{


  List<Music> ListMusics =[];
  final MusicFinder _audioPlayer =  MusicFinder() ;
  Song  currentSong;
  int posicao = -1;
  @override
  void initState() {
    loadingMuscis();
    super.initState();
  }

  Future _PlayLocal(String url) async{
      final  result = await  _audioPlayer.play(url,isLocal: true);
  }

  Future _stop() async{
      final result=  _audioPlayer.stop();
  }


  loadingMuscis()async{
    await  MusicFinder.allSongs().then((value){
        for(Song  song  in  value){
            setState(() {
                ListMusics.add(new Music(song: song));
            });
        }
    });

  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
         backgroundColor: Colors.orangeAccent.withOpacity(0.5),
          appBar: new AppBar(
            backgroundColor: Colors.black45,
            title: Text('Music Songs' , style: TextStyle(
               color: Colors.white,
            ),),
            centerTitle: true,
          ),
         body:Container(
               width: MediaQuery.of(context).size.width,
               margin: EdgeInsets.symmetric(
                   horizontal:5 ,
                   vertical: 5,
               ),
              child:ListView.builder(
                  itemCount:ListMusics.length,
                  itemBuilder: (context , index){
                     return InkWell(
                        onTap: (){
                            setState(() {
                                 posicao = index;
                                 currentSong = ListMusics[index].song;
                                 CleanCurrentASongs(ListMusics, index);
                            });
                        },
                         child:Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Container(
                             child: ListTile(
                               title: Text(ListMusics[index].song.title ,style: TextStyle(
                                 color: Colors.white ,
                                 fontSize: 12,
                               ),),
                               subtitle: Text(ListMusics[index].song.artist.toString()),
                               trailing:Icon(ListMusics[index].play? Icons.pause:Icons.play_arrow , color:Colors.white,),
                             ),
                            color: posicao  == index ? Colors.grey.withOpacity(0.4):Colors.transparent,
                         ) ,
                         index  != ListMusics.length-1?
                         Divider(
                           color: Colors.white,
                           height: 2,
                         ):SizedBox.shrink(),
                       ],
                     ));
                  }),
         ) ,
         floatingActionButton: FloatingActionButton(
           onPressed: (){
                if(posicao != -1){
                    showModalBottomSheet(context: context, builder:(context){
                        return Container(
                          width:MediaQuery.of(context).size.width,
                          height:120,
                          color:Colors.black45,
                          child:Row(
                             children: <Widget>[

                             ],
                          )
                        );
                    });
                }
           } ,
           backgroundColor: Colors.black54,
           child: posicao  == -1 ?Icon(Icons.play_arrow  ,size: 32,color: Colors.white,):ListMusics[posicao].play?Icon(Icons.pause,size: 32,color: Colors.white,):Icon(Icons.play_arrow  ,size: 32,color: Colors.white,),
         ),
         floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,

      );
  }

  void  CleanCurrentASongs(List<Music> listaComplete, index){
            for(int  i = 0 ;  i<ListMusics.length;  ++i){
              if(index  != i ){
                  setState(() {
                  ListMusics[i].play  = false;
                  });
              }
            }
  }
}

