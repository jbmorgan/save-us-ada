//
//  DialogueQueue.h
//  Save Us Ada
//
//  Created by Jon Morgan on 3/9/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define MAX_LENGTH 11

@interface DialogueQueue : CCNode {
	NSMutableArray *messageQueue;
	NSMutableArray *messages;
	ccTime timeSinceLastMessageDisplayed;
}

-(void)Update:(ccTime)dt;

-(void)enqueue:(NSString *)message;

@end
