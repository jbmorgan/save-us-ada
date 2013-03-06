//
//  TalkingHead.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "TalkingHead.h"


@implementation TalkingHead


-(id)initWithSpriteNamed:(NSString *)name {
	if(self = [super init]) {
		_sprite = [CCSprite spriteWithFile:name];
	}
	
	self.position = ccp(100,100);
	return self;
}

@end
