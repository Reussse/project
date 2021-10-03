import processing.serial.*;
Serial myport;

PImage montagnerose;
PImage thermo;
PImage ruler;
PImage ruler2;
PImage goutte;





String data ; 
String sb ; 


int c = 255 ; 
int ct = 0; 
void setup () { 
  
  
  montagnerose = loadImage("montagnerose.png");
  ruler = loadImage("ruler.png");
  ruler2 = loadImage("ruler2.png");
  goutte = loadImage("goutte.png");
  thermo = loadImage("thermo.png");
  image(montagnerose,0,0);
  image(ruler,220,630,150,200);
  image(ruler2,1280,630,150,200);
  image(goutte,240,340,130,200);
  image(thermo,1270,340,150,200);
  
  size(1687, 1054); 
  printArray(Serial.list());
  myport= new Serial(this, Serial.list()[2], 9600);
}
void draw() {
    montagnerose = loadImage("montagnerose.png");
  ruler = loadImage("ruler.png");
  ruler2 = loadImage("ruler2.png");
  goutte = loadImage("goutte.png");
  thermo = loadImage("thermo.png");
  image(montagnerose,0,0);
  image(ruler,220,630,150,200);
  image(ruler2,1280,630,150,200);
  image(goutte,240,340,130,200);
  image(thermo,1270,340,150,200);
  
  fill(c);
  
  rect (0, 0, 200, 150);
  
  fill(ct);
  textSize(45);
  text("X="+mouseX, 0, 50); 
  text("Y="+mouseY, 0, 120);
  while (myport.available() > 0) {

    sb = myport.readStringUntil('\n');
    if (sb != null)
    {
      sb = trim(sb);
      println(sb);
      int inputs[] = int(split(sb, ',')); 
      if (inputs.length == 3)
      {
        println(inputs[0]);
        println(inputs[1]);
        println(inputs[2]);
        println();

     
      }
      recte();
       fill(ct);
       text (inputs[0] + " %" , 575,465);
       text (inputs[1] , 1000,465);
       text (inputs[2] , 575,750);
       text (inputs[3] , 1000,750);
       
       {
         textSize(45);
         text("Relevé en temps réel de la météo des pistes", 360, 280);
       }
    {
       fill(#00008B);
       textSize(30);
       text("Humidité", 550, 350);
       
       fill(#8B0000);
       text("Température (en °C)", 875, 350);
     {
       fill(#000000);
       textSize(30);
       text("Hauteur de neige (en cm)", 442, 640);
       text("Hauteur du capteur (en cm)", 837, 640);
     }
    }
    }
  }
 delay(5000);
}
void mouseClicked() {//bouton
}
void recte(){
  //fill(#EEF5FF);
  noStroke();
  fill(225,225,255,100);
 rect(410,320,415,250);
 rect(830,320,415,250);
 rect(410,605,415,250);
 rect(830,605,415,250);
 
}
