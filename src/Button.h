//
//  Button.h
//  Whispers2
//
//  Created by James Bentley on 7/10/15.
//
//

#ifndef __Whispers2__Button__
#define __Whispers2__Button__

#include "ofMain.h"

class Button {
public:
    Button();
    void setup(int _x, int _y, int _w, int _h);
    void display();
    bool isInside(int _x, int _y);

    
    int x, y, width, height;
    ofTrueTypeFont font;
    bool clicked;
    int alpha;
    bool active;
};

#endif /* defined(__Whispers2__Button__) */
