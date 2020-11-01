import processing.pdf.*;

float a = 6;
float b = 18;
float c = 18;

float r;
float angle = TAU;
boolean drawing = false;
boolean saving = false;
boolean menu = true;
char focusedBox='_';
String savedKeys = "";
color c1 = color(255);
color c2 = color(255);

void setup(){
  //size(800, 800);
  fullScreen();
  //beginRecord(PDF, "Star "+str(a)+", "+str(b)+", "+str(c)+".pdf");
  r=((width<height)?width:height)/6;
  noFill();
  stroke(255);
  strokeWeight(.02);
}
void draw(){
  if (saving){
    beginRecord(PDF, "output/Star "+str(a)+", "+str(b)+", "+str(c)+".pdf");
    background(0);
    noFill();
    drawRose(a, b, c, r, 1000);
    endRecord();
    saving = !saving;
    drawing = !drawing;
  }else if (drawing){
    background(0);
    noFill();
    drawRose(a, b, c, r, 1000);
    drawing = !drawing;
  }else if (menu){
    drawMenu();
  }
  
}

void keyPressed(){
  if (key == ' ' && !menu){
    menu = true;
  }
  if (key != '#'){
    savedKeys+=key;
  }
  if (keyCode == BACKSPACE && savedKeys.length()>1){
    savedKeys = savedKeys.substring(0, savedKeys.length()-2);
  }
  if (focusedBox=='a'){
    a=parseFloat(savedKeys);
  }else if (focusedBox=='b'){
    b=parseFloat(savedKeys);
  }else if (focusedBox=='c'){
    c=parseFloat(savedKeys);
  }else if (focusedBox=='1'){
    String col = "FF" + savedKeys;
    while(col.length() < 8){col += '0';}
    c1=unhex(col);
  }else if (focusedBox=='2'){
    String col = "FF" + savedKeys;
    while(col.length() < 8){col += '0';}
    c2=unhex(col);
  }
}

float margin = 10;
float btnW = 100;

void mousePressed(){
  if(mouseX-(margin+50) < btnW*2 && mouseX-(margin+50) > 0 && mouseY-(margin*2+50) < 50 && mouseY-(margin*2+50) > 0){
    savedKeys = "";
    focusedBox='a';
  }else if(mouseX-(margin+50) < btnW*2 && mouseX-(margin+50) > 0 && mouseY-(margin*3+50*2) < 50 && mouseY-(margin*3+50*2) > 0){
    savedKeys = "";
    focusedBox='b';
  }else if(mouseX-(margin+50) < btnW*2 && mouseX-(margin+50) > 0 && mouseY-(margin*4+50*3) < 50 && mouseY-(margin*4+50*3) > 0){
    savedKeys = "";
    focusedBox='c';
  }else if(mouseX-(margin+200) < btnW*2 && mouseX-(margin+200) > 0 && mouseY-(margin*5+50*4) < 50 && mouseY-(margin*5+50*4) > 0){
    savedKeys = "";
    focusedBox='1';
  }else if(mouseX-(margin+200) < btnW*2 && mouseX-(margin+200) > 0 && mouseY-(margin*6+50*5) < 50 && mouseY-(margin*6+50*5) > 0){
    savedKeys = "";
    focusedBox='2';
  }else{
    focusedBox='_';
  }
  if(mouseX-margin < btnW && mouseX-margin > 0 && mouseY-margin < 50 && mouseY-margin > 0){
    menu = false;
    drawing = true;
  }else if(mouseX-(btnW+2*margin) < btnW && mouseX-(btnW+2*margin) > 0 && mouseY-margin < 50 && mouseY-margin > 0){
    menu = false;
    saving = true;
  }
}

void drawMenu(){
  background(0);
  fill(255);
  stroke(255);
  if(mouseX-margin < btnW && mouseX-margin > 0 && mouseY-margin < 50 && mouseY-margin > 0) fill(150, 150, 255);
  rect(margin, margin, btnW, 50);
  fill(255);
  if(mouseX-(btnW+2*margin) < btnW && mouseX-(btnW+2*margin) > 0 && mouseY-margin < 50 && mouseY-margin > 0) fill(150, 150, 255);
  rect(btnW+2*margin, margin, btnW, 50);
  textAlign(CENTER, CENTER);
  fill(0);
  stroke(0);
  textSize(18);
  text("Draw Rose", margin+btnW/2, margin+50/2);
  textSize(17);
  text("Save &\nDraw Rose", margin*2+btnW+btnW/2, margin+50/2);
  fill(255);
  stroke(255);
  textAlign(LEFT, TOP);
  textSize(32);
  text("a: ", margin, margin*2+50);
  if(mouseX-(margin+50) < btnW*2 && mouseX-(margin+50) > 0 && mouseY-(margin*2+50) < 50 && mouseY-(margin*2+50) > 0) fill(150, 150, 255);
  rect(margin+50, margin*2+50, btnW*2, 50);
  fill(0);
  text(str(a), margin*2+50, margin*2+50);
  
  fill(255);
  text("b: ", margin, margin*3+50*2);
  if(mouseX-(margin+50) < btnW*2 && mouseX-(margin+50) > 0 && mouseY-(margin*3+50*2) < 50 && mouseY-(margin*3+50*2) > 0) fill(150, 150, 255);
  rect(margin+50, margin*3+50*2, btnW*2, 50);
  fill(0);
  text(str(b), margin*2+50, margin*3+50*2);
  
  fill(255);
  text("c: ", margin, margin*4+50*3);
  if(mouseX-(margin+50) < btnW*2 && mouseX-(margin+50) > 0 && mouseY-(margin*4+50*3) < 50 && mouseY-(margin*4+50*3) > 0) fill(150, 150, 255);
  rect(margin+50, margin*4+50*3, btnW*2, 50);
  fill(0);
  text(str(c), margin*2+50, margin*4+50*3);
  
  
  fill(255);
  text("Inner Color: ", margin, margin*5+50*4);
  if(mouseX-(margin+200) < btnW*2 && mouseX-(margin+200) > 0 && mouseY-(margin*5+50*4) < 50 && mouseY-(margin*5+50*4) > 0) fill(150, 150, 255);
  rect(margin+200, margin*5+50*4, btnW*2, 50);
  fill(0);
  text('#'+hex(c1).substring(2,8), margin*2+200, margin*5+50*4);
  fill(c1);
  rect(margin*2+200+btnW*2, margin*5+50*4, 50, 50);
  
  fill(255);
  text("Outer Color: ", margin, margin*6+50*5);
  if(mouseX-(margin+200) < btnW*2 && mouseX-(margin+200) > 0 && mouseY-(margin*6+50*5) < 50 && mouseY-(margin*6+50*5) > 0) fill(150, 150, 255);
  rect(margin+200, margin*6+50*5, btnW*2, 50);
  fill(0);
  text('#'+hex(c2).substring(2,8), margin*2+200, margin*6+50*5);
  fill(c2);
  rect(margin*2+200+btnW*2, margin*6+50*5, 50, 50);
}


PVector rose(float a, float b, float c, float theta, float radius){
  // Terrible equation
  return new PVector(radius*(2+sin(a*theta)/2)*cos(theta+sin(b*theta)/c), -radius*(2+sin(a*theta)/2)*sin(theta+sin(b*theta)/c));
}

void drawRose(float a, float b, float c, float r, float shades){
  noFill();
  strokeWeight(.1);
  // Fills in the rose and shades it with width between lines
  for (int s = 0; s < shades; s++){
    stroke(lerpColor(c1, c2, (float) s / (shades-1)));
    //stroke(255);
    float rad = r*s/shades;
    beginShape();
    for (float i = 0; i < angle; i += TAU/1000){
      // Wherever the rose intersects a ray from the center, add a new vertex there
      PVector v = PVector.add(rose(a, b, c, i, rad), new PVector(width/2, height/2));
      vertex(v.x, v.y);
    }
    if (angle >= TAU){
      endShape(CLOSE);
    }else{
      endShape();
    }
  }
}
