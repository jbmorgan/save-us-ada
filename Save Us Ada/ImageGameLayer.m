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
		
		// ask director for the window size
//		CGSize size = [[CCDirector sharedDirector] winSize];
//		CGPoint center = ccp( size.width /2 , size.height/2 );
				
		imageGrid = [[ImageGrid alloc] init];
		imageGrid.position = ccp(340,180);
		[self addChild:imageGrid];
		
		
		[dialogueQueue enqueue:[NSString stringWithFormat:@"Picture. Picture.", nil]];
	}
	return self;
}

-(void)gridCellPressed:(id)sender {
	NSLog(@"Grid cell pressed!");
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
