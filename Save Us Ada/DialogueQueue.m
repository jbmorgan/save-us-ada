//
//  DialogueQueue.m
//  Save Us Ada
//
//  Created by Jon Morgan on 3/9/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "DialogueQueue.h"
#import "SimpleAudioEngine.h"

#define WIDTH 244
#define HEIGHT 463
#define MESSAGE_HEIGHT 40.0f
#define MIN_TIME_BETWEEN_MESSAGES 0.8f

@implementation DialogueQueue


-(id)initWithLength:(int)length
{
	if(self = [super init]) {
		maxLength = length;
		messages = [[NSMutableArray alloc] initWithCapacity:maxLength];
		messageQueue = [[NSMutableArray alloc] initWithCapacity:maxLength];
		self.position = ccp(142, 320);
		timeSinceLastMessageDisplayed = MIN_TIME_BETWEEN_MESSAGES;
	}
	return self;
}

-(void)Update:(ccTime)dt
{
	timeSinceLastMessageDisplayed += dt;
	
	if(timeSinceLastMessageDisplayed > MIN_TIME_BETWEEN_MESSAGES) {
		[self displayNextMessage];
	}

}

-(void)displayNextMessage {
	
	if(messageQueue.count < 1)
		return;
	
	timeSinceLastMessageDisplayed = 0;
	
	NSString *message = [messageQueue lastObject];

	if([message isEqualToString:@"Good job!"]) {
		[[SimpleAudioEngine sharedEngine] playEffect:@"goodjob.wav"];
	}
	
	CCLabelTTF *messageLabel = [[CCLabelTTF labelWithString:message dimensions:CGSizeMake(224.0f, MESSAGE_HEIGHT) hAlignment:kCCTextAlignmentLeft fontName:@"Mathlete-Bulky" fontSize:32] retain];
	messageLabel.opacity = 0.0;
	[messageLabel runAction:[CCFadeIn actionWithDuration:0.5]];
	messageLabel.position = ccp(0,-MESSAGE_HEIGHT);
	[self addChild:messageLabel];

	[messages insertObject:messageLabel atIndex:0];

	if(messages.count > maxLength) {
		CCLabelTTF *oldestMessage = [messages lastObject];
		[self removeChild:oldestMessage cleanup:NO];
		[messages removeLastObject];
	}
	
	CGFloat currentMessageHeight = 0.0f;
	
	for(CCLabelTTF *message in messages) {
		[message runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,currentMessageHeight)]];
		currentMessageHeight += MESSAGE_HEIGHT;
	}
	
	[messageQueue removeLastObject];
}

-(void)enqueue:(NSString *)message {
	[messageQueue insertObject:message atIndex:0];
}

@end
