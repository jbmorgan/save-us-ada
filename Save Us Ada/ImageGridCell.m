//
//  ImageGridCell.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ImageGridCell.h"


@implementation ImageGridCell

-(id)init {
	if(self = [super init]) {
		_selected = NO;
		onSprite = [CCSprite spriteWithFile:@"gridSquareOn.png"];
		offSprite = [CCSprite spriteWithFile:@"gridSquareOff.png"];
		onSprite.visible = _selected;
		offSprite.visible = !_selected;
		[self addChild:offSprite];
		[self addChild:onSprite];
	}
	return self;
}

-(void)toggle {
	_selected = !_selected;
	
	onSprite.visible = _selected;
	offSprite.visible = !_selected;
}

@end
