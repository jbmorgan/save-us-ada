//
//  ImageGrid.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define SIZE 7
#define SQUARE_SIZE 70

@class ImageGridCell;

@interface ImageGrid : CCNode {
    ImageGridCell* cells[SIZE][SIZE];
	BOOL targetState[SIZE][SIZE];
	CCLabelTTF *rowLabels[SIZE];
}

@end
