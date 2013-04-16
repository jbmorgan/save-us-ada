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
#define SECONDS_BEFORE_HINT 45

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
		indexOfCurentTotal = 0;
		targetTotals = [[NSArray arrayWithObjects:
						 [NSNumber numberWithInt:1],
						 [NSNumber numberWithInt:0],
						 [NSNumber numberWithInt:2],
						 [NSNumber numberWithInt:3],
						 [NSNumber numberWithInt:4],
						 [NSNumber numberWithInt:9],
						 [NSNumber numberWithInt:7],
						 [NSNumber numberWithInt:28],
						 [NSNumber numberWithInt:15],
						 nil] retain];
		
		currentHintLevel = kReminder;
		timeUntilNextHint = SECONDS_BEFORE_HINT;
		
		// create and initialize a Label
		selectedTotalLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(150.0f, 150.0f) hAlignment:kCCTextAlignmentCenter fontName:@"Mathlete-Bulky" fontSize:128];
		CCLabelTTF *combinationLabel = [CCLabelTTF labelWithString:@"7-28-15" dimensions:CGSizeMake(300.0f, 150.0f) hAlignment:kCCTextAlignmentCenter fontName:@"Mathlete-Bulky" fontSize:128];
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		//		CGPoint center = ccp( size.width /2 , size.height/2 );
		
		// position the label on the center of the screen
		selectedTotalLabel.position =  ccp(644, 150);
		combinationLabel.position =  ccp(644, 650);
		
		// add the label as a child to this Layer
		[self addChild: selectedTotalLabel];
		[self addChild: combinationLabel];
		
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
		
		[dialogueQueue enqueue:@"Look at these weird cards!"];
		[dialogueQueue enqueue:@"Each one has a number on"];
		[dialogueQueue enqueue:@"it... and a light below."];
		[dialogueQueue enqueue:@"Let's touch the card on"];
		[dialogueQueue enqueue:@"the right."];
		
		[self schedule:@selector(tick:)];
		
	}
	return self;
}

-(void)tick:(ccTime)dt {
	timeUntilNextHint -= dt;
	
	if(timeUntilNextHint < 0) {
		timeUntilNextHint = SECONDS_BEFORE_HINT;
		[self offerHint];
	}
}

-(void)offerHint {
	switch (currentHintLevel) {
		case kReminder:
			[dialogueQueue enqueue:@"Remember, we need to turn"];
			[dialogueQueue enqueue:@"on the cards that add up"];
			[dialogueQueue enqueue:[NSString stringWithFormat:@"to %i.", [targetTotals[indexOfCurentTotal] intValue]]];
			currentHintLevel = kNumberOfCards;
			break;
		case kNumberOfCards:
			[dialogueQueue enqueue:[NSString stringWithFormat:@"This one will need %i cards.", [self cardsForCurrentTarget]]];
			currentHintLevel = kLargestCard;
			break;
		case kLargestCard:
			[dialogueQueue enqueue:[NSString stringWithFormat:@"The highest card should be %i.", [self largestCardForCurrentTarget]]];
			currentHintLevel = kLargestCard;
			break;
		default:
			break;
	}
}

-(int)cardsForCurrentTarget {
	int cards = 0;
	int target = [targetTotals[indexOfCurentTotal] intValue];
	
	while(target > 0) {
		cards++;
		target = target / 2;
	}
	
	return cards;
}

-(int)largestCardForCurrentTarget {
	return pow(2, (int)log2([targetTotals[indexOfCurentTotal] intValue])) ;
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
	
	if(selectedTotal == [targetTotals[indexOfCurentTotal] intValue]) {
		[dialogueQueue enqueue:@"Good job!"];
		currentHintLevel = kReminder;
		
		//advance to the next target
		indexOfCurentTotal++;
		
		if(indexOfCurentTotal < targetTotals.count) {
			
			switch ([targetTotals[indexOfCurentTotal] intValue]) {
				case 0:
					[dialogueQueue enqueue:@"Whoa! That big number"];
					[dialogueQueue enqueue:@"changed down at the"];
					[dialogueQueue enqueue:@"bottom."];
					[dialogueQueue enqueue:@"We touched the 1 card, and now"];
					[dialogueQueue enqueue:@"it says 1."];
					[dialogueQueue enqueue:@"What happens if we touch"];
					[dialogueQueue enqueue:@"the same card again?"];
					break;
					
				case 2:
					[dialogueQueue enqueue:@"Great! Let's try making 2."];
					break;
				case 3:
					[dialogueQueue enqueue:@"Now try 3... We'll have to"];
					[dialogueQueue enqueue:@"turn on two cards to do"];
					[dialogueQueue enqueue:@"this one."];
					break;
				case 4:
					[dialogueQueue enqueue:@"Up next is 4..."];
					break;
				case 9:
					[dialogueQueue enqueue:@"You're pretty good at this."];
					[dialogueQueue enqueue:@"Can you make a 9?"];
					break;
				case 7:
					[dialogueQueue enqueue:@"Now for the hard stuff."];
					[dialogueQueue enqueue:@"See those numbers up top?"];
					[dialogueQueue enqueue:@"I think it's a combination."];
					[dialogueQueue enqueue:@"The first number is 7..."];
					break;
				case 28:
					[dialogueQueue enqueue:@"The second number is 28..."];
					break;
				case 15:
					[dialogueQueue enqueue:@"The last number is 15."];
					break;
				default:
					[dialogueQueue enqueue:[NSString stringWithFormat:@"Can you make %i?", [targetTotals[indexOfCurentTotal] intValue]]];
					break;
			}
			
		} else {
			[dialogueQueue enqueue:@"The door is opening!"];
			[dialogueQueue enqueue:@"Fantastic!"];
			
			indexOfCurentTotal = 0;
			
			//advance to the next story point
			[self performSelector:@selector(advanceToNextStoryPoint) withObject:nil afterDelay:3.0];
		}
		
	}
	
}

-(void)advanceToNextStoryPoint {
	[GameStateManager instance].storyPoint = kHopper;
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
