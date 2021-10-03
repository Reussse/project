
 //Import de la librairie communication serie
 import processing.serial.*;
 
 //Initialisation des variables
 Serial monPort;  //Déclaration port série pour la lecture des données envoyées par l'Arduino
 int mesure;      //Mesure lue sur le port 

//Initialisation des variables

 int temperature=25;      //Temperature mesurée par l'Arduino
 int tempmini=34;         //Temperature mini mesurée par l'Arduino
 int tempmax=12;          //Temperature maxi mesurée par l'Arduino
 int j;                   //Indice de travail
 int k;
 int l;
 int m;
 int n;
 int o;
 int x=0;                 //Abcisse
 int x0=0;                //Abcisse précédente
 int y=0;                 //Ordonnée
 int y0;                  //Ordonnée précédente
 int premier = 0;         // Bypass premiere valeur erronée

//Traitements d'initialisation
void setup() {
  
 //Initialisations port série
 println(Serial.list());    // Affichage dans la console de la liste des ports serie du PC
 monPort = new Serial(this, "COM3", 9600);   //Initialisation de la communicaiton port serie
 monPort.bufferUntil('\n'); //Attend la réception d'un fin de ligne pour généer un serialEvent() 
 
 //Initialisatiopns graphiques
 size (1920,1080);
 background(#FFFAFA);
 smooth();  //On active le lissage

 //Dessin des cadres -------------------------
 stroke(0);
 strokeWeight(1);
 fill(230);
 rect (240,540,1525,490); //hauteur neige
 rect (240,20,760,515); //Courbe tempé
 rect(1005, 20, 760, 515); //courbe humidité

 //Dessin des titres  -------------------------
 fill(255,0,0);
 text("Historique température", 520, 40);
 text("Historique humidité", 1290, 40);
 text("Historique hauteur de neige", 950, 560);
 fill(0,0,255);
 textSize (42);
 textSize (12);

 //Affichage courbe -----------------------

 //Tracé des axes
 fill(0,0,255);
 stroke(#0650E4);
 strokeWeight(2);
  
 //horizontal
 line (290, 315,960,315);
 triangle(960, 315, 950, 320, 950, 310);
 text("Température (°C)", 250, 40);
 
 //vertical
 line (290,516,290,50);
 triangle(290, 50, 295, 60, 285, 60);
 text("Temps", 920, 340);

 //Gradations et textes tous les °
 fill(0,0,255);
 strokeWeight(2);
 stroke(#0650E4);
 for (int i = -5; i < 7; i++) {
     j=i*40;
     k=i*5;
     line(285, 315-j, 290,315-j);
     text(k, 255, 320-j);
 }

 //Gradations fines des °
 strokeWeight(1);
 stroke(#0650E4);
 for (int i = 0; i < 55; i++) {
          j=i*8;
          line(285, 515-j, 290,515-j);
 }

 //Gradations des minutes
 strokeWeight(2);
 for (int i = 0; i < 11; i++) {
          j=i*60;
          line(290+j, 315, 290+j,320);
          text(i, 295+j, 330);
          
 }
          
//Affichage courbe -----------------------

 //Tracé des axes
 fill(0,0,255);
 stroke(#0650E4);
 strokeWeight(2);
  
 //horizontal
 line (1050,475,1750,475);
 triangle(1750, 475, 1740, 480, 1740, 470);
 text("Humidité (%)", 1050, 40);
 
 //vertical
 line (1050,475,1050,50);
 triangle(1050, 50, 1055, 60, 1045, 60);
 text("Temps", 1700, 510);

 //Gradations et textes tous les 10 %
 fill(0,0,255);
 strokeWeight(2);
 stroke(#0650E4);
 for (int i = 0; i < 11; i++) {
     l=i*40;
     m=i*10;
     line(1045, 475-l, 1050,475-l);
     text(m, 1020, 480-l);
 }

 //Gradations fines des %
 strokeWeight(1);
 stroke(#0650E4);
 for (int i = 0; i < 100; i++) {
          l=i*4;
          line(1045, 475-l, 1050,475-l);
 }

 //Gradations des minutes
 strokeWeight(2);
 for (int i = 0; i < 11; i++) {
          l=i*60;
          line(1050+l, 475, 1050+l,480);
          text(i, 1055+l, 490);
 }
 //Affichage courbe -----------------------
 
 //Tracé des axes
 fill(0,0,255);
 stroke(#0650E4);
 strokeWeight(2);
  
 //horizontal
 line (290,1000,1750,1000);
 triangle(1750, 1000, 1740, 1005, 1740, 995);
 text("Temps", 1690, 1020);
 
 //vertical
 line (290,1000,290,575);
 triangle(290, 575, 295, 585, 285, 585);
 text("Hauteur (cm)", 250, 560);

 //Gradations et textes tous les 10cm
 fill(0,0,255);
 strokeWeight(2);
 stroke(#0650E4);
 for (int i = 0; i < 11; i++) {
     n=i*40;
     o=i*20;
     line(285, 1000-n, 290,1000-n);
     text(o, 255, 995-n);
 }

 //Gradations fines des %
 strokeWeight(1);
 stroke(#0650E4);
 for (int i = 0; i < 50; i++) {
          n=i*8;
          line(285, 1000-n, 290,1000-n);
 }

 //Gradations des minutes
 strokeWeight(2);
 for (int i = 0; i < 11; i++) {
          n=i*135;
          line(290+n, 1000, 290+n,1005);
          text(i, 295+n, 1015);
 }


}
//
//Traitements itératifs 
 void draw() {
        // Pas de traitement car tout est réalisé dans la fonction serialEvent()
   }

//Traitements à réception d'une fin de ligne
 void serialEvent (Serial monPort) {
 
 //Récupération sur le port série de la temperature sous forme de chaine de caractères
 String tempcar = monPort.readStringUntil('\n');
 if (tempcar != null && premier == 1) {
      tempcar = trim(tempcar); // Suppression des blancs
      int tempInt = int(tempcar);
      float temperature = float (tempcar);
  //    float temperature = tempInt;
      println ("La temperature est de : " + temperature + " : " + tempInt);
 
      //Dessin graphe avec temperature actuelle -----------------------
      stroke (0,255,0);
      strokeWeight(1);
  
      //dessin du nouveau point sur la courbe
      x0=x; // Mémorisation abscisse point précédent
      x=x+5; // L'Arduino envoie une nouvelle mesure de température toutes les 5 secondes
      if (x >600) {x=5;}
    
      y0=y; // Mémorisation ordonnée point précédent
      y = tempInt*8; // Un degré correpond à 8 points sur les ordonnées
    
      if (y > tempmax*8)  {tempmax = y/8;} //Mise à jour temp max
      if (y < tempmini*8) {tempmini = y/8;} //Mise à jour temp min
    
      if (x == 5) {   //Si on rédémarre une nouvelle courbe
        noStroke();
        fill(230);
        rect(291,65,655,410); //Effacement courbe précédente
        point(x+287,475-y);
      }
      else {
        line(x0+287,475-y0,x+286,475-y);
      }
    
      //Affichage des températures ----------------
    
      //Dessin des cadres -------------------------
      stroke(0);
      strokeWeight(1);
      fill(230);
      rect (20,525,210,65);
    
      //Textes
      fill(0,0,255);
      text("Température actuelle :", 40, 540);
      text("Température mini :", 40, 560);
      text("Température max :", 40, 580);
      textAlign(RIGHT);
      fill(#0BB305);
      text(tempInt+" °C", 220, 540);
      fill(0,0,255);
      text(tempmini+" °C", 220, 560);
      fill(255,0,0);
      text(tempmax+" °C", 220, 580);
      textAlign(LEFT);
   
   }
   premier = 1;
 }
