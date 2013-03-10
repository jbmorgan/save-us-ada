//
//  GameLayer.h
//  Save Us Ada
//
//  Created by Jon Morgan on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class TalkingHead, DialogueQueue;

@interface GameLayer : CCLayer {
	TalkingHead	*ada;
	DialogueQueue *dialogueQueue;
}

// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;

-(void)Update:(ccTime)dt;

@end
