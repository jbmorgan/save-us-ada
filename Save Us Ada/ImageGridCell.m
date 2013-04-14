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
		
		_button = [CCMenuItemImage itemWithNormalImage:@"gridbutton.png" selectedImage:@"gridbutton.png" target:self selector:@selector(toggle)];
	}
	return self;
}

-(void)reset {
	_selected = NO;
	onSprite.visible = _selected;
	offSprite.visible = !_selected;
}

-(void)toggle {
	_selected = !_selected;
	
	onSprite.visible = _selected;
	offSprite.visible = !_selected;
}

@end
