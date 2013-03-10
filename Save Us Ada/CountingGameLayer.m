//
//  CountingGameLayer.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CountingGameLayer.h"
#import "StoryPointLayer.h"
#import "GameStateManager.h"
#import "TalkingHead.h"
#import "DialogueQueue.h"

#define NUM_OF_CARDS 5

@implementation CountingGameLayer

// Helper class method that creates a Scene with the CountingGameLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CountingGameLayer *layer = [CountingGameLayer node];
	
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
		
		selectedTotal = 0;
		targetTotal = (arc4random() % 31) + 1;
		
		// create and initialize a Label
		selectedTotalLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150.0f, 150.0f) hAlignment:kCCTextAlignmentCenter fontName:@"Mathlete-Bulky" fontSize:128];
				
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
//		CGPoint center = ccp( size.width /2 , size.height/2 );
		
		// position the label on the center of the screen
		selectedTotalLabel.position =  ccp(644, 150);
		
		// add the label as a child to this Layer
		[self addChild: selectedTotalLabel];
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		cardMenuItems[4] = [CCMenuItemImage itemWithNormalImage:@"16card.png" selectedImage:@"16cardselected.png" target:self selector:@selector(cardPressed:)];
		cardMenuItems[3] = [CCMenuItemImage itemWithNormalImage:@"8card.png" selectedImage:@"8cardselected.png" target:self selector:@selector(cardPressed:)];
		cardMenuItems[2] = [CCMenuItemImage itemWithNormalImage:@"4card.png" selectedImage:@"4cardselected.png" target:self selector:@selector(cardPressed:)];
		cardMenuItems[1] = [CCMenuItemImage itemWithNormalImage:@"2card.png" selectedImage:@"2cardselected.png" target:self selector:@selector(cardPressed:)];
		cardMenuItems[0] = [CCMenuItemImage itemWithNormalImage:@"1card.png" selectedImage:@"1cardselected.png" target:self selector:@selector(cardPressed:)];
				
		CCMenu *menu = [CCMenu menuWithItems:cardMenuItems[4], cardMenuItems[3], cardMenuItems[2], cardMenuItems[1], cardMenuItems[0], nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp(644, size.height/2 + 50)];
		
		// Add the menu to the layer
		[self addChild:menu];
		
		for(int i = 0; i < NUM_OF_CARDS; i++) {
			cardSelected[i] = NO;
			CCSprite *offButton = [CCSprite spriteWithFile:@"button-off.png"];
			CCSprite *onButton = [CCSprite spriteWithFile:@"button-on.png"];
			offButtons[i] = offButton;
			onButtons[i] = onButton;
			onButton.opacity = 0;
			offButton.position = onButton.position = ccp(380+132*i, 300);
			
			[self addChild:offButton];
			[self addChild:onButton];
		}
				
		[dialogueQueue enqueue:[NSString stringWithFormat:@"Can you make %i?", targetTotal]];
		
	}
	return self;
}

-(void)cardPressed:(id)sender {
	
	int cardIndex = -1;

	for(int i = 0; i < NUM_OF_CARDS; i++) {
		if(sender == cardMenuItems[i]) {
			cardIndex = i;
			break;
		}
	}
	
	cardSelected[cardIndex] = !cardSelected[cardIndex];
	
	if(cardSelected[cardIndex]) {
		selectedTotal += (1 << cardIndex);
		[onButtons[NUM_OF_CARDS-1-cardIndex] runAction:[CCFadeIn actionWithDuration:0.1]];
	} else {
		selectedTotal -= (1 << cardIndex);
		[onButtons[NUM_OF_CARDS-1-cardIndex] runAction:[CCFadeOut actionWithDuration:0.1]];
	}
	
	[selectedTotalLabel setString:[NSString stringWithFormat:@"%i", selectedTotal]];
	
	if(selectedTotal == targetTotal) {		
		while(targetTotal == selectedTotal) {
			targetTotal = arc4random() % 32;
		}
		
		[dialogueQueue enqueue:@"Good job!"];
		[dialogueQueue enqueue:[NSString stringWithFormat:@"Can you make %i?", targetTotal]];
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
