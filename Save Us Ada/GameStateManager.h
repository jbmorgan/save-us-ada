//
//  GameStateManager.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum StoryPoint {
	kBabbage,
	kHopper,
	kTuring,
	kEnd
} StoryPoint;

@interface GameStateManager : NSObject {
    
}

@property StoryPoint storyPoint;
+(GameStateManager *)instance;

@end
