//
//  ImageGrid.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class ImageGridCell;

@interface ImageGrid : CCNode {
    
}

@property (readonly) int width;
@property (readonly) int height;
@property (readonly, retain) NSMutableArray *columns;

-(id)initWithWidth:(int)w andHeight:(int)h;

@end
