//
//  MainMenuScreenLayer.m
//  Save Us Ada
//
//  Created by Jon Morgan on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScreenLayer.h"
#import "CountingGameLayer.h"
#import "StoryPointLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

@implementation MainMenuScreenLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuScreenLayer *layer = [MainMenuScreenLayer node];
	
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
		CCSprite *backgroundImage = [CCSprite spriteWithFile:@"SplashScreen.png"];
		
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		CGPoint center = ccp( size.width /2 , size.height/2 );
		
		backgroundImage.position = center;
		
		// add the label as a child to this Layer
		[self addChild:backgroundImage];
		
		//
		// Leaderboards and Achievements
		//
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:70];
		[CCMenuItemFont setFontName:@"Mathlete-Bulky"];
		
		// Achievement Menu Item using blocks
		CCMenuItem *itemAchievement = [CCMenuItemFont itemWithString:@"Achievements" block:^(id sender) {
			
			
			GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
			achivementViewController.achievementDelegate = self;
			
			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
			
			[[app navController] presentModalViewController:achivementViewController animated:YES];
			
			[achivementViewController release];
		}];
		
		// Leaderboard Menu Item using blocks
		CCMenuItem *itemLeaderboard = [CCMenuItemFont itemWithString:@"Leaderboard" block:^(id sender) {
			
			
			GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
			leaderboardViewController.leaderboardDelegate = self;
			
			AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
			
			[[app navController] presentModalViewController:leaderboardViewController animated:YES];
			
			[leaderboardViewController release];
		}];
		
		CCMenuItem *playMenuItem = [CCMenuItemFont itemWithString:@"Play" block:^(id sender) {
			NSLog(@"playGame");
			[[CCDirector sharedDirector] replaceScene:[StoryPointLayer scene]];
		}];
		
		CCMenu *menu = [CCMenu menuWithItems:playMenuItem, itemAchievement, itemLeaderboard, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 140)];
		
		// Add the menu to the layer
		[self addChild:menu];
		
	}
	return self;
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

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
