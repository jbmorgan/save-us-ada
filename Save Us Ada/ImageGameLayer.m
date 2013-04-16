//
//  ImageGameLayer.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ImageGameLayer.h"
#import "StoryPointLayer.h"
#import "GameStateManager.h"
#import "TalkingHead.h"
#import "DialogueQueue.h"
#import "ImageGrid.h"


@implementation ImageGameLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ImageGameLayer *layer = [ImageGameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		door = [[NSArray arrayWithObjects:
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2],nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:3], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil],
				 nil] retain];
		
		key = [[NSArray arrayWithObjects:
				[NSArray arrayWithObjects:[NSNumber numberWithInt:7],nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:7],nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:5], nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1],[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:5], nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:5], nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:7], nil],
				nil] retain];
		
		ball = [[NSArray arrayWithObjects:
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2],nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:5], [NSNumber numberWithInt:1],nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:7],nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:7],nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:7],nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:5], [NSNumber numberWithInt:1],nil],
				 [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:2],nil],
				 nil] retain];
		
		cat =	[[NSArray arrayWithObjects:
				  [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1],[NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil],
				  [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:2],[NSNumber numberWithInt:3], [NSNumber numberWithInt:2], nil],
				  [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:7], nil],
				  [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:2],[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2],nil],
				  [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:7], nil],
				  [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:7], nil],
				  [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:5], [NSNumber numberWithInt:1], nil],
				  nil] retain];
		
		currentImageType = kBall;
		imageGrid = [[ImageGrid alloc] initWithEncoding:ball];
		imageGrid.position = ccp(340,180);
		[self addChild:imageGrid];
		
		[dialogueQueue enqueue:[NSString stringWithFormat:@"You can tap the squares", nil]];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"to turn them on or off.", nil]];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"The numbers to the side", nil]];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"tell you how to make a", nil]];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"picture.", nil]];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"For instance, \"3, 4\" means", nil]];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"that the first three squares", nil]];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"are white and the next", nil]];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"four are black.", nil]];
		
		[self schedule:@selector(tick:)];
		
	}
	return self;
}

-(void)tick:(ccTime)dt
{
	if([imageGrid matchesTarget]) {
		NSLog(@"match");
		[dialogueQueue enqueue:[NSString stringWithFormat:@"Good job!", nil]];
		
		//load the next puzzle
		switch (currentImageType) {
			case kBall:
				[dialogueQueue enqueue:[NSString stringWithFormat:@"It looks like a ball!", nil]];
				[dialogueQueue enqueue:[NSString stringWithFormat:@"What's next?", nil]];
				currentImageType = kCat;
				[imageGrid setEncoding:cat];
				break;
				
			case kCat:
				[dialogueQueue enqueue:[NSString stringWithFormat:@"It's a cat! Meow!", nil]];
				[dialogueQueue enqueue:[NSString stringWithFormat:@"What's next?", nil]];
				currentImageType = kDoor;
				[imageGrid setEncoding:door];
				break;
				
			case kDoor:
				[dialogueQueue enqueue:[NSString stringWithFormat:@"It looks like a door!", nil]];
				[dialogueQueue enqueue:[NSString stringWithFormat:@"Maybe we can open it...", nil]];
				[dialogueQueue enqueue:[NSString stringWithFormat:@"Oh no, it's locked!", nil]];
				[dialogueQueue enqueue:[NSString stringWithFormat:@"Maybe the next picture", nil]];
				[dialogueQueue enqueue:[NSString stringWithFormat:@"will help us?", nil]];
				currentImageType = kKey;
				[imageGrid setEncoding:key];
				break;
				
			case kKey:
				[dialogueQueue enqueue:[NSString stringWithFormat:@"It's a key!", nil]];
				[dialogueQueue enqueue:[NSString stringWithFormat:@"It unlocked the cage!", nil]];
				[self unschedule:@selector(tick:)];
				//skip to the next game
				[self performSelector:@selector(advanceToNextStoryPoint) withObject:self afterDelay:4.0];
				break;
			default:
				break;
		}
	} else {
//		NSLog(@"no match");
	}
}

-(void)advanceToNextStoryPoint {
	[GameStateManager instance].storyPoint = kTuring;
	[[CCDirector sharedDirector] replaceScene:[StoryPointLayer scene]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
