//
//  CountingGameLayer.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLayer.h"

@class TalkingHead, DialogueQueue;

typedef enum HintLevel {
	kLevel0,
	kLevel1,
	kLevel2,
} HintLevel;

@interface CountingGameLayer : GameLayer {
    int selectedTotal;
	NSArray *targetTotals;
	int indexOfCurentTotal;
	
	CCLabelTTF	*selectedTotalLabel;

	BOOL cardSelected[5];
	CCMenuItem *cardMenuItems[5];
	CCSprite *offButtons[5];
	CCSprite *onButtons[5];
	
	HintLevel currentHintLevel;
	ccTime timeUntilNextHint;
}

-(void)cardPressed:(id)sender;

@end
