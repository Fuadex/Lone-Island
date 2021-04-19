ArrayList<Artist> artistList = new ArrayList<Artist>();
ArrayList NewTags = new ArrayList();


import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int arr[] = {1, 2, 3, 4, 5};
  
PrintWriter output;

void setup() {
  size(500,500);
  smooth();
  
  
  
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  
  PFont font = loadFont("Arial-BoldMT-48.vlw");
  textFont(font, 24);
  textAlign(CENTER);
  
  
  output = createWriter("Pink2.txt");
  
  String NewTags[] = loadStrings("Pink Floyd2.csv");
  for(int z = 0; z < NewTags.length; z++){
      println(NewTags[z]);
        String tag = NewTags[z];  //Chooses the line
  tag = tag.replaceAll(" ", "+");
  tag = tag.replaceAll(",", "%2C"); //Only if a comma is as part of the link (web does not like commas)
  tag = tag.replaceAll("%2C",","); // Only if the code relies on python script (it produces %2C, splitting does not like %2C)
  String[] list = split(tag, ','); //Chooses the word
  println(list[10]);
    
    for (int x = 5; x < 15; x++){
  
  XML xml = loadXML("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=GET_YOUR_OWN_API_BRUH&tags="+list[x]+"&per_page=1&sort=relevance&format=rest"); 
  //println(xml);
  XML artists_node = xml.getChildren("photos")[0];
  XML[] artists = artists_node.getChildren("photo");
  
  float penX = 0;
  float penY = 0;
  for (int i=0; i < artists.length; i++) {
    println(list[x]);
    XML name_node = artists_node.getChildren("photo")[i];
    String id = name_node.getString("id");
    String secret = name_node.getString("secret");
    String server = name_node.getString("server");
    String farm = name_node.getString("farm");
    PImage img = loadImage("https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+"_s.jpg");
    println("https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+"_s.jpg");


    output.println("https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+"_b.jpg");

    delay(500);


  }
  }
}
      output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
}

void draw() {
  
  
  
  background(255);
  /*
  for(int i=0; i < artistList.size(); i++){
    artistList.get(i).moveArtist(i); 
  }
  
  for(int i=0; i < artistList.size(); i++){
    artistList.get(i).drawArtist(); 
  }
  
  for(int i=0; i < artistList.size(); i++){
    artistList.get(i).checkAndDrawHoverText(); 
  }*/
  
  //float penX = 0;
  //float penY = 0;
  //for(int i=0; i < artistList.size(); i++){
  //  PImage img = artistList.get(i).img; 
  //  image(img, penX, penY);
  //  penX = penX + img.width;
  //  if(penX >= width){
  //    penX = 0;
  //    penY = penY + img.height;
  //  }
  //}
  /*for(int i=0; i < imageList.size(); i++){
    PImage img = imageList.get(i); 
    image(img, (i*34) % width, (i*34)/width * 34);
  }*/
  
}


void mousePressed() {
  /* create a new osc message object */
  OscMessage myMessage = new OscMessage("/test");
  
  myMessage.add(123); /* add an int to the osc message */
  myMessage.add(12.34); /* add a float to the osc message */
  myMessage.add("some text"); /* add a string to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/test")==true) {
    /* check if the typetag is the right one. */
    if(theOscMessage.checkTypetag("ifs")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      int firstValue = theOscMessage.get(0).intValue();  
      float secondValue = theOscMessage.get(1).floatValue();
      String thirdValue = theOscMessage.get(2).stringValue();
      print("### received an osc message /test with typetag ifs.");
      println(" values: "+firstValue+", "+secondValue+", "+thirdValue);
      return;
    }  
  } 
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}