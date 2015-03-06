FloatTable consoleInformationMicrosoft;
FloatTable consoleInformationSony;
FloatTable consoleInformationNintendo;

int modeSwitch=1;
float consoleInformationMinM, consoleInformationMaxM;
float consoleInformationMinS, consoleInformationMaxS;
float consoleInformationMinN, consoleInformationMaxN;
int x1, y1;
int plotX1, plotY1;
int plotX2, plotY2;
int rowCount;
int columnCount;
int currentColumn = 0;
int yearMinM, yearMaxM;
int [] releaseYearsM;

int yearMinS, yearMaxS;
int [] releaseYearsS;

int yearMinN, yearMaxN;
int [] releaseYearsN;

int yearIntervalM = 1;
int salesIntervalM = 10;
int salesIntervalMMinor = 5;

int yearIntervalS = 1;
int salesIntervalS = 10;
int salesIntervalSMinor = 5;

int yearIntervalN = 1;
int salesIntervalN = 10;
int salesIntervalNMinor = 5;

String [] linesM;
String [] linesS;
String [] linesN;

void setup() {
  size(1000, 500);
  consoleInformationMicrosoft = new FloatTable("consoleInformationM.txt");
  consoleInformationSony = new FloatTable("consoleInformationS.txt");
  consoleInformationNintendo = new FloatTable("consoleInformationN.txt"); 
  processFiles();
  plotX1 = 100;
  plotX2 = width-plotX1;
  plotY1 = 100;
  plotY2 = height-plotY1;

  if (modeSwitch == 1) {
    rowCount = consoleInformationMicrosoft.getRowCount();
    columnCount = consoleInformationMicrosoft.getColumnCount();
    releaseYearsM = int(consoleInformationMicrosoft.getRowNames());
    yearMinM = releaseYearsM[0];
    yearMaxM = releaseYearsM[releaseYearsM.length - 1];
    consoleInformationMinM = 0;
    consoleInformationMaxM = ceil(consoleInformationMicrosoft.getTableMax() / salesIntervalM) * salesIntervalM;
  }
}

void draw() {
  background(150);
  if (modeSwitch == 1) {
    background(200);
    smooth();
    x1 = 900;
    y1 = 400;
    fill(255);
    noStroke();
    rectMode(CORNERS);
    rect(x1, y1, width-x1, height-y1);    
    fill(5,178,0);
    textSize(75);
    textAlign(CENTER);
    text("Microsoft", width/2, height-(y1+25));
    textSize(14);
    text("Lifetime", width - 960, height/2);
    text("Sales", width - 960, height/2 + 25);
    textSize(10);
    text("(in Millions)", width-960, height/2+40);
    textSize(14);
    text("Years Released", width/2, height/2 + 220);
    yearLabels();
    salesLabels();
    drawConsoleInformationPlots(currentColumn);
    drawConsoleInformationLine(currentColumn);
    mouseOver(currentColumn);
  } else if (modeSwitch == 2) {
    background(200);
    smooth();
    x1 = 900;
    y1 = 400;
    fill(255);
    noStroke();
    rectMode(CORNERS);
    rect(x1, y1, width-x1, height-y1);
    fill(0,0,255);
    textSize(75);
    textAlign(CENTER);
    text("Sony", width/2, height-(y1+25));
    textSize(14);
    text("Lifetime", width - 960, height/2);
    text("Sales", width - 960, height/2 + 25);
    textSize(10);
    text("(in Millions)", width-960, height/2+40);
    textSize(14);
    text("Years Released", width/2, height/2 + 220);
    yearLabels();
    salesLabels();
    drawConsoleInformationPlots(currentColumn);
    drawConsoleInformationLine(currentColumn);
    mouseOver(currentColumn);
  } else if (modeSwitch == 3) {
    background(200);
    smooth();
    x1 = 900;
    y1 = 400;
    fill(255);
    noStroke();
    rectMode(CORNERS);
    rect(x1, y1, width-x1, height-y1);
    fill(255,0,0);
    textSize(75);
    textAlign(CENTER);
    text("Nintendo", width/2, height-(y1+25));
    textSize(14);
    text("Lifetime", width - 960, height/2);
    text("Sales", width - 960, height/2 + 25);
    textSize(10);
    text("(in Millions)", width-960, height/2+40);
    textSize(14);
    text("Years Released", width/2, height/2 + 220);
    yearLabels();
    salesLabels();
    drawConsoleInformationPlots(currentColumn);
    drawConsoleInformationLine(currentColumn);
    mouseOver(currentColumn);
  }
}

void drawConsoleInformationPlots(int col) {
  for (int row = 0; row < rowCount; row++) {
    if (modeSwitch == 1) {
      if (consoleInformationMicrosoft.isValid(row, col)) {
        float value = consoleInformationMicrosoft.getFloat(row, col);
        float x = map(releaseYearsM[row], yearMinM, yearMaxM, plotX1, plotX2);
        float y = map(value, consoleInformationMinM, consoleInformationMaxM, plotY2, plotY1);
        strokeWeight(5);
        fill(0,255,0);
        point(x, y);
      }
    } else if (modeSwitch == 2) {
      if (consoleInformationSony.isValid(row, col)) {
        float value = consoleInformationSony.getFloat(row, col);
        float x = map(releaseYearsS[row], yearMinS, yearMaxS, plotX1, plotX2);
        float y = map(value, consoleInformationMinS, consoleInformationMaxS, plotY2, plotY1);      
        strokeWeight(5);
        fill(0,0,255);
        point(x, y);
      }
    } else if (modeSwitch == 3) {
      if (consoleInformationNintendo.isValid(row, col)) {
        float value = consoleInformationNintendo.getFloat(row, col);
        float x = map(releaseYearsN[row], yearMinN, yearMaxN, plotX1, plotX2);
        float y = map(value, consoleInformationMinN, consoleInformationMaxN, plotY2, plotY1);      
        strokeWeight(5);
        fill(255,0,0);
        point(x, y);
      }
    }
  }
}

void drawConsoleInformationLine(int col) {
  if (modeSwitch == 1) {
    noFill();
    stroke(0,255,0);
    strokeWeight(0.5);
    beginShape();
    for (int row = 0; row < rowCount; row++) {
      if (consoleInformationMicrosoft.isValid(row, col)) {
        float value = consoleInformationMicrosoft.getFloat(row, col);
        float x = map(releaseYearsM[row], yearMinM, yearMaxM, plotX1, plotX2);
        float y = map(value, consoleInformationMinM, consoleInformationMaxM, plotY2, plotY1);      
        vertex(x, y);
      }
    }
    endShape();
  } else if (modeSwitch == 2) {
    noFill();
    stroke(0,0,255);
    strokeWeight(0.5);
    beginShape();
    for (int row = 0; row < rowCount; row++) {
      if (consoleInformationSony.isValid(row, col)) {
        float value = consoleInformationSony.getFloat(row, col);
        float x = map(releaseYearsS[row], yearMinS, yearMaxS, plotX1, plotX2);
        float y = map(value, consoleInformationMinS, consoleInformationMaxS, plotY2, plotY1);      
        vertex(x, y);
      }
    }
    endShape();
  } else if (modeSwitch == 3) {
    noFill();
    stroke(255,0,0);
    strokeWeight(0.5);
    beginShape();
    for (int row = 0; row < rowCount; row++) {
      if (consoleInformationNintendo.isValid(row, col)) {
        float value = consoleInformationNintendo.getFloat(row, col);
        float x = map(releaseYearsN[row], yearMinN, yearMaxN, plotX1, plotX2);
        float y = map(value, consoleInformationMinN, consoleInformationMaxN, plotY2, plotY1);      
        vertex(x, y);
      }
    }
    endShape();
  }
}

void yearLabels() {
  if (modeSwitch == 1) {
    fill(0);
    textSize(10);
    textAlign(CENTER);

    stroke(224);
    strokeWeight(1);

    for (int row = 0; row < rowCount; row++) {
      if (releaseYearsM[row] % yearIntervalM == 0) {
        float x = map(releaseYearsM[row], yearMinM, yearMaxM, plotX1, plotX2);
        text(releaseYearsM[row], x, plotY2 + textAscent() + 10);
        line(x, plotY1, x, plotY2);
      }
    }
  } else if (modeSwitch == 2) {
    fill(0);
    textSize(10);
    textAlign(CENTER);

    stroke(224);
    strokeWeight(1);

    for (int row = 0; row < rowCount; row++) {
      if (releaseYearsS[row] % yearIntervalS == 0) {
        float x = map(releaseYearsS[row], yearMinS, yearMaxS, plotX1, plotX2);
        text(releaseYearsS[row], x, plotY2 + textAscent() + 10);
        line(x, plotY1, x, plotY2);
      }
    }
  } else if (modeSwitch == 3) {
    fill(0);
    textSize(10);
    textAlign(CENTER);

    stroke(224);
    strokeWeight(1);

    for (int row = 0; row < rowCount; row++) {
      if (releaseYearsN[row] % yearIntervalN == 0) {
        float x = map(releaseYearsN[row], yearMinN, yearMaxN, plotX1, plotX2);
        text(releaseYearsN[row], x, plotY2 + textAscent() + 10);
        line(x, plotY1, x, plotY2);
      }
    }
  }
}

void salesLabels() {
 
  if (modeSwitch == 1) {
    fill(0);
    textSize(10);
    textAlign(RIGHT);

    stroke(128);
    strokeWeight(1);

    for (float v = consoleInformationMinM; v <= consoleInformationMaxM; v += salesIntervalMMinor) {
      if (v % salesIntervalMMinor == 0) { 
        float y = map(v, consoleInformationMinM, consoleInformationMaxM, plotY2, plotY1);  
        if (v % salesIntervalM == 0) {
          float textOffset = textAscent()/2;
          if (v == consoleInformationMinM) {
            textOffset = 0;                  
          } else if (v == consoleInformationMaxM) {
            textOffset = textAscent(); 
          }
          fill(0);
          stroke(5);
          text(floor(v), plotX1 - 10, y + textOffset);
          line(plotX1 - 4, y, plotX1, y);
        }
      }
    }
  } else if (modeSwitch == 2) {
    fill(0);
    textSize(10);
    textAlign(RIGHT);

    stroke(128);
    strokeWeight(1);
    for (float v = consoleInformationMinS; v <= consoleInformationMaxS; v += salesIntervalSMinor) {
      if (v % salesIntervalSMinor == 0) {
        float y = map(v, consoleInformationMinS, consoleInformationMaxS, plotY2, plotY1);  
        if (v % salesIntervalS == 0) {
          float textOffset = textAscent()/2;
          if (v == consoleInformationMinS) {
            textOffset = 0;
          } else if (v == consoleInformationMaxS) {
            textOffset = textAscent();
          }
          fill(0);
          stroke(5);
          text(floor(v), plotX1 - 10, y + textOffset);
          line(plotX1 - 4, y, plotX1, y);
        }
      }
    }
  } else if (modeSwitch == 3) {
    fill(0);
    textSize(10);
    textAlign(RIGHT);

    stroke(128);
    strokeWeight(1);
    for (float v = consoleInformationMinN; v <= consoleInformationMaxN; v += salesIntervalNMinor) {
      if (v % salesIntervalNMinor == 0) { 
        float y = map(v, consoleInformationMinN, consoleInformationMaxN, plotY2, plotY1);  
        if (v % salesIntervalN == 0) {
          float textOffset = textAscent()/2;
          if (v == consoleInformationMinN) {
            textOffset = 0; 
          } else if (v == consoleInformationMaxN) {
            textOffset = textAscent();
          }
          fill(0);
          stroke(5);
          text(floor(v), plotX1 - 10, y + textOffset);
          line(plotX1 - 4, y, plotX1, y);
        }
      }
    }
  }
}

void mouseOver(int col) {
  if (modeSwitch == 1) {
    for (int row = 0; row < rowCount; row++) {
      if (consoleInformationMicrosoft.isValid(row, col)) {
        float value = consoleInformationMicrosoft.getFloat(row, col);
        float x = map(releaseYearsM[row], yearMinM, yearMaxM, plotX1, plotX2);
        float y = map(value, consoleInformationMinM, consoleInformationMaxM, plotY2, plotY1);
        if (dist(mouseX, mouseY, x, y) < 3) {
          strokeWeight(10);
          point(x, y);
          fill(0);
          textSize(8);
          textAlign(LEFT);
          text(nf(value, 0, 2) + " (" + linesM[row] + ", " + releaseYearsM[row] + ")", x, y-8);
          textAlign(LEFT);
        }
      }
    }
  } else if (modeSwitch == 2) {
    for (int row = 0; row < rowCount; row++) {
      if (consoleInformationSony.isValid(row, col)) {
        float value = consoleInformationSony.getFloat(row, col);
        float x = map(releaseYearsS[row], yearMinS, yearMaxS, plotX1, plotX2);
        float y = map(value, consoleInformationMinS, consoleInformationMaxS, plotY2, plotY1);
        if (dist(mouseX, mouseY, x, y) < 3) {
          strokeWeight(10);
          point(x, y);
          fill(0);
          textSize(8);
          textAlign(LEFT);
          text(nf(value, 0, 2) + " (" + linesS[row] + ", " +  releaseYearsS[row] + ")", x, y-8);
          textAlign(LEFT);
        }
      }
    }
  } else if (modeSwitch == 3) {
    for (int row = 0; row < rowCount; row++) {
      if (consoleInformationNintendo.isValid(row, col)) {
        float value = consoleInformationNintendo.getFloat(row, col);
        float x = map(releaseYearsN[row], yearMinN, yearMaxN, plotX1, plotX2);
        float y = map(value, consoleInformationMinN, consoleInformationMaxN, plotY2, plotY1);
        if (dist(mouseX, mouseY, x, y) < 3) {
          strokeWeight(10);
          point(x, y);
          fill(0);
          textSize(8);
          textAlign(LEFT);
          text(nf(value, 0, 2) + " (" + linesN[row] + ", " +  releaseYearsN[row] + ")", x, y-8);
          textAlign(LEFT);
        }
      }
    }
  }
}

void keyPressed() {
  if (key == 'q' || key == 'Q') {
    modeSwitch = 1;
    consoleInformationMicrosoft = new FloatTable("consoleInformationM.txt"); 
    rowCount = consoleInformationMicrosoft.getRowCount();
    columnCount = consoleInformationMicrosoft.getColumnCount();
    releaseYearsM = int(consoleInformationMicrosoft.getRowNames());
    yearMinM = releaseYearsM[0];
    yearMaxM = releaseYearsM[releaseYearsM.length - 1];
    consoleInformationMinM = 0;
    consoleInformationMaxM = ceil(consoleInformationMicrosoft.getTableMax() / salesIntervalM) * salesIntervalM;
  } else if (key == 'w' || key == 'W') {
    modeSwitch = 2;
    consoleInformationSony = new FloatTable("consoleInformationS.txt"); 
    rowCount = consoleInformationSony.getRowCount();
    columnCount = consoleInformationSony.getColumnCount();
    releaseYearsS = int(consoleInformationSony.getRowNames());
    yearMinS = releaseYearsS[0];
    yearMaxS = releaseYearsS[releaseYearsS.length - 1];
    consoleInformationMinS = 0;
    consoleInformationMaxS = ceil(consoleInformationSony.getTableMax() / salesIntervalS) * salesIntervalS;
  } else if (key == 'e' || key == 'E') {
    modeSwitch = 3;
    consoleInformationNintendo = new FloatTable("consoleInformationN.txt"); 
    rowCount = consoleInformationNintendo.getRowCount();
    columnCount = consoleInformationNintendo.getColumnCount();
    releaseYearsN = int(consoleInformationNintendo.getRowNames());
    yearMinN = releaseYearsN[0];
    yearMaxN = releaseYearsN[releaseYearsN.length - 1];
    consoleInformationMinN = 0;
    consoleInformationMaxN = ceil(consoleInformationNintendo.getTableMax() / salesIntervalN) * salesIntervalN;
  }
}

void processFiles() {
  linesM = loadStrings("consoleM.txt");
  linesS = loadStrings("consoleS.txt");
  linesN = loadStrings("consoleN.txt");
}

