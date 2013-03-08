//
//  CountingGameLayer.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CountingGameLayer.h"


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
		
		for(int i = 0; i < 5; i++) {
			cards[i] = NO;
		}
		
		// create and initialize a Label
		selectedTotalLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(200.0f, 100.0f) hAlignment:kCCTextAlignmentRight fontName:@"Marker Felt" fontSize:64];
		CCSprite *backgroundImage = [CCSprite spriteWithFile:@"SplashScreen.png"];
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		CGPoint center = ccp( size.width /2 , size.height/2 );
		
		
		// position the label on the center of the screen
		selectedTotalLabel.position =  ccp(1024-120,40);
		backgroundImage.position = center;
		
		// add the label as a child to this Layer
//		[self addChild:backgroundImage];
		[self addChild: selectedTotalLabel];
		
		
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
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		// Add the menu to the layer
		[self addChild:menu];
		
	}
	return self;
}

-(void)cardPressed:(id)sender {
	
	if(sender == sixteenCard) {
		cards[4] = !cards[4];
		if(cards[4])
			selectedTotal += 16;
		else
			selectedTotal -= 16;
	} else if(sender == eightCard) {
		cards[3] = !cards[3];
		if(cards[3])
			selectedTotal += 8;
		else
			selectedTotal -= 8;
	} else if(sender == fourCard) {
		cards[2] = !cards[2];
		if(cards[2])
			selectedTotal += 4;
		else
			selectedTotal -= 4;
	} else if(sender == twoCard) {
		cards[1] = !cards[1];
		if(cards[1])
			selectedTotal += 2;
		else
			selectedTotal -= 2;
	} else if(sender == oneCard) {
		cards[0] = !cards[0];
		if(cards[0])
			selectedTotal += 1;
		else
			selectedTotal -= 1;
	}
	
	NSLog(@"%i", selectedTotal);
	[selectedTotalLabel setString:[NSString stringWithFormat:@"%i", selectedTotal]];
		
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
