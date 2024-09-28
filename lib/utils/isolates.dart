

import 'dart:isolate';

getMultipleImagesIsolate(SendPort sendport){
  int total=0;
  for(int i=0;i<100000000;i++){
    total=0+i;
  }
sendport.send(total);
}