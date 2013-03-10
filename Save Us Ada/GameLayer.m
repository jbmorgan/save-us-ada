//
//  GameLayer.m
//  Save Us Ada
//
//  Created by Jon Morgan on 3/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "StoryPointLayer.h"
#import "GameStateManager.h"
#import "TalkingHead.h"
#import "DialogueQueue.h"

@implementation GameLayer

// Helper class method that creates a Scene with the CountingGameLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
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
		
		ada = [[TalkingHead alloc] initWithSpriteNamed:@"ada-portrait.png"];
		dialogueQueue = [[DialogueQueue alloc] initWithLength:9];
		
		CCSprite *backgroundImage = [CCSprite spriteWithFile:@"GameplayBackground.png"];
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		CGPoint center = ccp( size.width /2 , size.height/2 );
		
		
		// position the label on the center of the screen
		backgroundImage.position = center;
		
		// add the label as a child to this Layer
		[self addChild:backgroundImage];
		[self addChild: ada];
		[self addChild: dialogueQueue];
		
		//
		// Leaderboards and Achievements
		//
		
		//schedules [self Update:dt] to run every 1/60th second
		[self schedule:@selector(Update:)];
	}
	return self;
}

-(void)Update:(ccTime)dt
{
    if(![[CCDirector sharedDirector] isPaused]) {
		[dialogueQueue Update:dt];
	}
}

-(void)advanceToStoryPoint:(StoryPoint)storyPoint {
	[GameStateManager instance].storyPoint = storyPoint;
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
