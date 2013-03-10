//
//  ImageGameLayer.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class TalkingHead, DialogueQueue;

@interface ImageGameLayer : CCLayer {
	TalkingHead	*ada;
	DialogueQueue *dialogueQueue;
}

// returns a CCScene that contains the CountingGameLayer as the only child
+(CCScene *) scene;
-(void)advanceToNextStoryPoint;
-(void)gridCellPressed:(id)sender;

@end
