//
//  CountingGameLayer.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CountingGameLayer.h"
#import "TalkingHead.h"
#import "DialogueQueue.h"


@implementation CountingGameLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
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
		

		
		ada = [[TalkingHead alloc] initWithSpriteNamed:@"ada-portrait.png"];
		dialogueQueue = [[DialogueQueue alloc] initWithLength:9];
		
		// create and initialize a Label
		selectedTotalLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(200.0f, 100.0f) hAlignment:kCCTextAlignmentRight fontName:@"Mathlete-Bulky" fontSize:64];
		
		CCSprite *backgroundImage = [CCSprite spriteWithFile:@"GameplayBackground.png"];
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		CGPoint center = ccp( size.width /2 , size.height/2 );
		
		
		// position the label on the center of the screen
		selectedTotalLabel.position =  ccp(1024 - 140,40);
		backgroundImage.position = center;
		
		// add the label as a child to this Layer
		[self addChild:backgroundImage];
		[self addChild: selectedTotalLabel];
		[self addChild: ada];
		[self addChild: dialogueQueue];
		
		//
		// Leaderboards and Achievements
		//
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
		
		sixteenCard = [CCMenuItemImage itemWithNormalImage:@"16card.png" selectedImage:@"16cardselected.png" target:self selector:@selector(cardPressed:)];
		eightCard = [CCMenuItemImage itemWithNormalImage:@"8card.png" selectedImage:@"8cardselected.png" target:self selector:@selector(cardPressed:)];
		fourCard = [CCMenuItemImage itemWithNormalImage:@"4card.png" selectedImage:@"4cardselected.png" target:self selector:@selector(cardPressed:)];
		twoCard = [CCMenuItemImage itemWithNormalImage:@"2card.png" selectedImage:@"2cardselected.png" target:self selector:@selector(cardPressed:)];
		oneCard = [CCMenuItemImage itemWithNormalImage:@"1card.png" selectedImage:@"1cardselected.png" target:self selector:@selector(cardPressed:)];
				
		CCMenu *menu = [CCMenu menuWithItems:sixteenCard, eightCard, fourCard, twoCard, oneCard, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( 644, size.height/2 + 50)];
		
		// Add the menu to the layer
		[self addChild:menu];
		
		for(int i = 0; i < 5; i++) {
			cards[i] = NO;
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
	
	//holy Jesus, this is rough
	//fix this up ASAP
	int cardIndex = -1;

	if(sender == sixteenCard) {
		cardIndex = 4;
	} else if(sender == eightCard) {
		cardIndex = 3;
	} else if(sender == fourCard) {
		cardIndex = 2;
	} else if(sender == twoCard) {
		cardIndex = 1;
	} else if(sender == oneCard) {
		cardIndex = 0;
	}
	
	
	cards[cardIndex] = !cards[cardIndex];
	
	if(cards[cardIndex]) {
		selectedTotal += (1 << cardIndex);
		[onButtons[4-cardIndex] runAction:[CCFadeIn actionWithDuration:0.1]];
	} else {
		selectedTotal -= (1 << cardIndex);
		[onButtons[4-cardIndex] runAction:[CCFadeOut actionWithDuration:0.1]];
	}
	
	[selectedTotalLabel setString:[NSString stringWithFormat:@"%i", selectedTotal]];
	
	if(selectedTotal == targetTotal) {		
		while(targetTotal == selectedTotal) {
			targetTotal = arc4random() % 32;
		}
		
		[dialogueQueue enqueue:[NSString stringWithFormat:@"Good job! Can you make %i?", targetTotal]];
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
