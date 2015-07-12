//
//  Button.cpp
//  Whispers2
//
//  Created by James Bentley on 7/10/15.
//
//

#include "Button.h"

Button::Button() {
    width = height = x = y = 0;
    font.loadFont("bembo-bold.ttf", 68);
    alpha = 255;
    clicked = false;
}

void Button::setup(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    width = _w;
    height = _h;
}

void Button::display() {
    ofSetColor(255, 255, 253, alpha);
    ofRectRounded(x, y, width, height, 10);
    ofSetColor(162, 164, 149, alpha);
    font.drawString("Begin", x + width/2 - font.getStringBoundingBox("Begin", 0, 0).width/2, y + height/2 + 20 - font.getStringBoundingBox("Begin", 0, 0).height/2);
    font.drawString("Journey", x + width/2 - font.getStringBoundingBox("Journey", 0, 0).width/2, y + height - font.getStringBoundingBox("Journey", 0, 0).height/2);
    if(clicked && alpha > 0) alpha -= 2;
}

bool Button::isInside(int _x, int _y) {
    if((_x > x && _x < x+width) && (_y > y && _y < y+width)) return true;
    else return false;
}