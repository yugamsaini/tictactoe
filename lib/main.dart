import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];

var winner = "";

var currentplayer = 'X';
void drawxo(i){
  if(grid[i] == '-'){
    setState(() {
    grid[i] = currentplayer;
    //after X the value should change to O
    currentplayer = currentplayer == 'X' ? 'O' : 'X';
  });

  findWinner(grid[i]);
  }
}

bool checkMove(i1,i2,i3,sign){
  if(grid[i1] == sign && grid[i2] == sign && grid[i3] == sign){
    return true;
  }
  return false;
}
void findWinner(currentSign){
  if(checkMove(0,1,2,currentSign) || checkMove(3,4,5,currentSign) || checkMove(6,7,8,currentSign) ||
  checkMove(0,3,6,currentSign) || checkMove(1,4,7,currentSign) || checkMove(2,5,8,currentSign) ||
  checkMove(0,4,8,currentSign) || checkMove(2,4,6,currentSign) 
  )//diagonal)
  {
    setState(() {
       winner = currentSign;
    });
    // winner = currentSign;
    //print('$currentSign won');
  }
}
void reset(){
  setState(() {
    winner = "";
    grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];
  });
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Center(
          child: Column(
            children: [
              if(winner != "") Text('$winner won the game',style:TextStyle(fontSize:30),),
              Container(
                //constraint so that web mein size badhane prr iska size na badhe
                constraints: BoxConstraints(maxHeight: 400,maxWidth: 400),
                //margin on all sides
                margin : EdgeInsets.all(20),
                color : Colors.black,
                child: GridView.builder(
                  
                  //grid ko jitna space chahiye utna lega bs
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      //for spacing between rows
                      mainAxisSpacing: 10),
                  itemCount: grid.length,
                  //here there was center now we have to make - clickable
                  //so we have to make center to inkwell widget
              
                  itemBuilder: (context, index) => Material(
                    //colorsof individual cell
                    color : Colors.amber,
                    child: InkWell(
                    splashColor: Colors.black,//colors on click
                      //method to determine what will happen on click
                      //onTap: (){},
                      onTap : ()=>drawxo(index),
                      child: Center(
                          child: Text(
                        grid[index],
                        style: TextStyle(fontSize: 50),
                      )),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(onPressed: reset, icon: Icon(Icons.refresh), label: Text('play again'))
            ],
          ),
        ),
      ),
    );
  }
}
