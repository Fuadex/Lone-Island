class Artist {

  PImage img;
  float x;
  float y;

  public Artist(PImage img, float x, float y) {
    this.img = img;
    this.x = x;
    this.y = y;
  }
  
  void moveArtist(int i){
   this.y += sin(frameCount*0.03+i*TWO_PI/10)*this.img.height*0.05;
  }

  void drawArtist() {
    image(this.img, this.x, this.y);
  }

  void checkAndDrawHoverText() {
    if (mouseX > this.x 
      && mouseX < this.x+this.img.width
      && mouseY > this.y
      && mouseY < this.y+this.img.height) {
      fill(255);
    }
  }
}