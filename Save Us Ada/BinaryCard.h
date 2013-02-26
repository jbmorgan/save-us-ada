//
//  BinaryCard.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum CardValue {
	kOne = 1,
	kTwo = 2,
	kFour = 4,
	kEight = 8,
	kSixteen = 16
} CardValue;

@interface BinaryCard : CCNode {
    
}

@property (readonly, retain) CCSprite *sprite;
@property (readonly) int value;
@property (readonly) BOOL selected;

-(id)initWithValue:(CardValue)v;

@end
