//
//  DialogueQueue.m
//  Save Us Ada
//
//  Created by Jon Morgan on 3/9/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "DialogueQueue.h"

#define WIDTH 244
#define HEIGHT 463
#define MESSAGE_HEIGHT 50.0f

@implementation DialogueQueue


-(id)initWithLength:(int)length {
	if(self = [super init]) {
		maxLength = length;
		_messages = [[NSMutableArray alloc] initWithCapacity:maxLength];
		self.position = ccp(142, 320);
	}
	return self;
}

-(void)enqueue:(NSString *)message {
	
	CCLabelTTF *messageLabel = [[CCLabelTTF labelWithString:message dimensions:CGSizeMake(224.0f, MESSAGE_HEIGHT) hAlignment:kCCTextAlignmentLeft fontName:@"Mathlete-Bulky" fontSize:32] retain];
	messageLabel.opacity = 0.0;
	[messageLabel runAction:[CCFadeIn actionWithDuration:0.5]];
	messageLabel.position = ccp(0,-MESSAGE_HEIGHT);
	[self addChild:messageLabel];
	
	[_messages insertObject:messageLabel atIndex:0];
	
	if(_messages.count > maxLength) {
		CCLabelTTF *oldestMessage = [_messages lastObject];
		[self removeChild:oldestMessage cleanup:NO];
		[_messages removeLastObject];
	}
	
	CGFloat currentMessageHeight = 0.0f;
	
	for(CCLabelTTF *message in _messages) {		
		[message runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,currentMessageHeight)]];
		currentMessageHeight += MESSAGE_HEIGHT;
	}
}

@end
