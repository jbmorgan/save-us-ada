//
//  StoryPointLayer.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StoryPointLayer.h"
#import "CountingGameLayer.h"
#import "GameStateManager.h"
#import "TalkingHead.h"

@implementation StoryPointLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	StoryPointLayer *layer = [StoryPointLayer node];
	
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
		
		NSString *prisonerImage = nil;
		NSString *storyText = nil;
		gameplayScene = nil;
		
		switch ([GameStateManager instance].storyPoint) {
			case kBabbage:
				prisonerImage = @"babbage-portrait.png";
				storyText = @"Oh noes, Charles Babbage has been kidnapped again!! Solve this puzzle to save him!";
				gameplayScene = [CountingGameLayer scene];
				break;
				
			case kHopper:
				prisonerImage = @"hopper-portrait.png";
				storyText = @"Oh noes, Grace Hopper has been kidnapped again!! Solve this puzzle to save her!";
				gameplayScene = [CountingGameLayer scene];
				break;
				
			case kTuring:
				prisonerImage = @"turing-portrait.png";
				storyText = @"Oh noes, Alan Turing has been kidnapped again!! Solve this puzzle to save him!";
				gameplayScene = [CountingGameLayer scene];
				break;
				
			default:
				break;
		}
		
		[gameplayScene retain];
		
		prisoner = [[TalkingHead alloc] initWithSpriteNamed:prisonerImage];
		prisoner.position = ccp(1024-prisoner.position.x, prisoner.position.y);
		
		CCSprite *prison = [CCSprite spriteWithFile:@"jail.png"];
		prison.position = prisoner.position;
		
		// create and initialize a Label
		CCLabelTTF *messageLabel = [CCLabelTTF labelWithString:storyText dimensions:CGSizeMake(600.0f, 400.0f) hAlignment:kCCTextAlignmentLeft fontName:@"Mathlete-Bulky" fontSize:64];
		
		backgroundImage = [CCSprite spriteWithFile:@"StoryPointBackground.png"];
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		CGPoint center = ccp( size.width /2 , size.height/2 );
		
		
		// position the label on the center of the screen
		messageLabel.position =  center;
		backgroundImage.position = center;
		
		// add the label as a child to this Layer
		[self addChild:backgroundImage];
		[self addChild: messageLabel];
		[self addChild: ada];
		[self addChild: prisoner];
		[self addChild: prison];
		
		//register to receive targeted touch events
		[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
																  priority:0
														   swallowsTouches:YES];
	}
	return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSLog(@"Touch Began");
	return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    /*
     CGPoint location = [touch locationInView: [touch view]];
     CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
     */
	NSLog(@"Touch Moved");
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    /*
     CGPoint location = [touch locationInView: [touch view]];
     CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
     */
	NSLog(@"Touch Ended");
	[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
	[[CCDirector sharedDirector] replaceScene:gameplayScene];
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
