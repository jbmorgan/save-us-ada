//
//  ImageGridCell.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ImageGridCell : CCNode {
    CCSprite *onSprite;
	CCSprite *offSprite;
}

@property (readwrite) BOOL selected;
@property (readonly) CCMenuItem *button;
-(void)toggle;
-(void)reset;
@end
