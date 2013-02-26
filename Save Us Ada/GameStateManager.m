//
//  GameStateManager.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameStateManager.h"


@implementation GameStateManager

static GameStateManager *_gameStateManager = nil;

//gets the global singleton instance of the GameStateManager
+(GameStateManager *)instance {
	if(!_gameStateManager) {
		_gameStateManager = [[self alloc] init];
	}
	
	return _gameStateManager;
}

@end
