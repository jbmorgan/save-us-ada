//
//  StoryPointLayer.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class TalkingHead;

@interface StoryPointLayer : CCLayer {
    CCSprite *backgroundImage;
	
	TalkingHead *ada,
				*prisoner;
	
	int textIndex;
	CCScene *gameplayScene;
	CCLabelTTF *messageLabel;
	NSArray *storyText;
}


// returns a CCScene that contains the StoryPointLayer as the only child
+(CCScene *) scene;

@end
