Button chooseFileButton;

void setup() {
  //sets up document
  size(500,500);
  
  //needs to be HSB to get brightness value
  colorMode(HSB, 100);
  
  //create instructions
  fill(0);
  String instructions = "Choose a directory with\n jpegs to process.";
  textSize(22);
  textAlign(CENTER);
  text(instructions, width/2, height/5);
  
  textSize(12);
  String csvText = "Processed folders will show up as a .CSV under /data \nin the same root  as this Processing program";
  text(csvText, width/2, height*(2/5.5));
  
  //create UI Button
  textSize(18);
  color btnCol = color(23,60,80);
  color btnColHover = color(3,60,100);
  int btnWidth = 150;
  int btnHeight = 50;
  chooseFileButton = new Button("Choose File", (width-btnWidth)/2, height/2, btnWidth, btnHeight, btnCol, btnColHover);
}

/*
* Goes through every pixel in an image to find
* its brightness value. 
* 
* @param filename file to parse (must have extension)
* @return int averageBrightness
*/
int findBrightness(String filename){
  
  //load images
  PImage img= loadImage(filename);
  img.loadPixels();
  int brightSum = 0;
  
  //go through every pixel and save thr brightness
  for(int i = 0; i<img.width*img.height; i++){
    brightSum+=brightness(img.pixels[i]);
  }
  
  //get average of brightSum and return it
  brightSum/=(img.width*img.height);
  return (brightSum);
}

/*
* Goes through every pixel in an image to find
* its brightness value. Makes calculations per section.
* Returns average of each section in an array.
* If the numOfSection doesn't evenly divide, the program
* will add a new section and calculate that as as well.
*
* @param filename file to parse (must have extension)
* @param numOfSection how many equal divisions image should have
* @return int[] average brightness per division
*/
int[] findBrightnessSection(String filename, int numOfSection){
  
  //load images
  PImage img = loadImage(filename);
  img.loadPixels();
  
  //create variables
  int brightSum = 0;
  int sectionIndex =0;
  int sectionHeight = (int)Math.ceil(1.0 * img.height /  numOfSection);
  int[] brightCollection;
  
  //add new section if numOfSection doesn't evenly divide image height
  if(img.height %  numOfSection!=0){
    brightCollection = new int[numOfSection+1];
  }
  else{
    brightCollection = new int[numOfSection];
  }
  
  //loop through each pixel to calculate brightness
  int count = 0;
  for (int y = 0; y < img.height; y++ ) {
    for (int x = 0; x < img.width; x++) {
    
    int loc = x + y*img.width;
    brightSum+=brightness(img.pixels[loc]);
    count++;
    
      //if end of section is reached, save brightSum's average and reset count
      if(x==img.width-1 && y%sectionHeight==0){
        brightCollection[sectionIndex++] = brightSum/count;
        count = 0;
        brightSum=0;
      }
    }
  }
  
  // do something with the extras if numOfSection 
  // doesn't fully go into image height
  
  if(img.height%numOfSection!=0){
    brightCollection[sectionIndex] = brightSum/count;
  }
  
  return (brightCollection);
}

void draw(){
  chooseFileButton.hover();
}

void mousePressed(){
  if(chooseFileButton.pressed()){
    fileChoose();
  }
}
