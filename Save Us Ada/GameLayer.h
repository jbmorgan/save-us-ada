//
//  GameLayer.h
//  Save Us Ada
//
//  Created by Jon Morgan on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define SECONDS_BEFORE_HINT 15

@class TalkingHead, DialogueQueue;

typedef enum HintLevel {
	kLevel0,
	kLevel1,
	kLevel2,
} HintLevel;

@interface GameLayer : CCLayer {
	TalkingHead	*ada;
	DialogueQueue *dialogueQueue;
	
	HintLevel currentHintLevel;
	ccTime timeUntilNextHint;
}

// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;

-(void)tick:(ccTime)dt;
-(void)offerHint;

@end
