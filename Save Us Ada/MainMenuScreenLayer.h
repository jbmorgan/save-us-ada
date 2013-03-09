//
//  MainMenuScreenLayer.h
//  Save Us Ada
//
//  Created by Jon Morgan on 3/5/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>

@interface MainMenuScreenLayer : CCLayer  <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate> {
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
