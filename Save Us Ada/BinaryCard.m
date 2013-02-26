//
//  BinaryCard.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "BinaryCard.h"


@implementation BinaryCard


-(id)initWithValue:(CardValue)v {
	if(self = [super init]) {
		_value = v;
		
		switch(v) {
			case kOne:
				_sprite = [CCSprite spriteWithFile:@"onecard.png"];
				break;
			case kTwo:
				_sprite = [CCSprite spriteWithFile:@"twocard.png"];
				break;
			case kFour:
				_sprite = [CCSprite spriteWithFile:@"fourcard.png"];
				break;
			case kEight:
				_sprite = [CCSprite spriteWithFile:@"eightcard.png"];
				break;
			case kSixteen:
				_sprite = [CCSprite spriteWithFile:@"sixteencard.png"];
				break;
			default:
				return nil;
		}
	}
	return self;
}

@end
