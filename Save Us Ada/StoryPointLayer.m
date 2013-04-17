//
//  StoryPointLayer.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StoryPointLayer.h"
#import "CountingGameLayer.h"
#import "ImageGameLayer.h"
#import "WordGameLayer.h"
#import "GameStateManager.h"
#import "TalkingHead.h"
#import "SimpleAudioEngine.h"

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
		
		NSArray *babbageText = [NSArray arrayWithObjects:
								@"Ada: Oh noes! The evil Professor Dos D. Dossington has kidnapped Charles Babbage again!",
								@"Charles: Help meeee!",
								@"Ada: How can we get him out of that cage?",
								@"Charles: Dossington was messing with these cards on the cage. I think it has something to do with that!",
								nil];
		
		NSArray *babbageTextSaved = [NSArray arrayWithObjects:
									 @"Ada: He's saved!",
									 @"Charles: I'm saved!",
									 @"Ada: Yay!",
									 @"Charles: But your princess is in another castle.",
									 @"Ada: What?",
									 @"Charles: He also got our friend Grace Hopper.",
									 nil];
		
		NSArray *hopperText = [NSArray arrayWithObjects:
							   @"Grace: He put me in a cage! WHO DOES THAT?!?",
							   @"Ada: What's this on this cage? It's kind of like a checkerboard and a bunch of numbers.",
							   @"Ada: Maybe we can figure out what it all means.",
							   nil];
		
		NSArray *hopperTextSaved = [NSArray arrayWithObjects:
									@"Grace: Thanks!",
									nil];
		
		NSArray *turingText = [NSArray arrayWithObjects:
							   @"Ada: Oh no! Now Alan Turing's been kidnapped!",
							   @"Alan: Worse things have happened. I would like to get out of here, though.",
							   @"Ada: You're the father of computing! I won't leave you in there forever!",
							   @"Alan: How can you know it won't take you forever?",
							   nil];
		
		textIndex = 0;
		
		switch ([GameStateManager instance].storyPoint) {
			case kBabbage:
				prisonerImage = @"babbage-portrait.png";
				storyText = babbageText;
				nextSceneClass = [CountingGameLayer class];
				break;
				
			case kBabbageSaved:
				prisonerImage = @"babbage-portrait.png";
				storyText = babbageTextSaved;
				nextSceneClass = [StoryPointLayer class];
				break;
				
			case kHopper:
				prisonerImage = @"hopper-portrait.png";
				storyText = hopperText;
				nextSceneClass = [ImageGameLayer class];
				break;
				
			case kHopperSaved:
				prisonerImage = @"hopper-portrait.png";
				storyText = hopperTextSaved;
				nextSceneClass = [StoryPointLayer class];
				break;
				
			case kTuring:
				prisonerImage = @"turing-portrait.png";
				storyText = turingText;
				nextSceneClass = [WordGameLayer class];
				break;
				
			default:
				break;
		}
		
		[storyText retain];
		
		prisoner = [[TalkingHead alloc] initWithSpriteNamed:prisonerImage];
		prisoner.position = ccp(1024-prisoner.position.x, prisoner.position.y);
		
		CCSprite *prison = [CCSprite spriteWithFile:@"jail.png"];
		prison.position = prisoner.position;
		
		// create and initialize a Label
		messageLabel = [CCLabelTTF labelWithString:storyText[textIndex] dimensions:CGSizeMake(600.0f, 400.0f) hAlignment:kCCTextAlignmentLeft fontName:@"Mathlete-Bulky" fontSize:64];
		
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
		
		if([GameStateManager instance].storyPoint == kBabbage || [GameStateManager instance].storyPoint == kHopper || [GameStateManager instance].storyPoint == kTuring) {
			[self addChild: prison];
			[[SimpleAudioEngine sharedEngine] playEffect:@"ohnose.wav"];
		}
		
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
	
	textIndex++;
	
	if(textIndex < storyText.count) {
		[messageLabel setString:storyText[textIndex]];
	} else {
		
		if([GameStateManager instance].storyPoint == kBabbageSaved) {
			[GameStateManager instance].storyPoint = kHopper;
		} else if ([GameStateManager instance].storyPoint == kHopperSaved) {
			[GameStateManager instance].storyPoint = kTuring;
		}
		
		[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
		[[CCDirector sharedDirector] replaceScene:[nextSceneClass scene]];
	}
	
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
