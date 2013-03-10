//
//  DialogueQueue.h
//  Save Us Ada
//
//  Created by Jon Morgan on 3/9/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DialogueQueue : CCNode {
	int maxLength;
	NSMutableArray *messages;
}

-(id)initWithLength:(int)length;
-(void)enqueue:(NSString *)message;

@end
