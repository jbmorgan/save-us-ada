//
//  ImageGrid.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ImageGrid.h"
#import "ImageGridCell.h"


@implementation ImageGrid

-(id)init {
	if(self = [super init]) {
		
		for(int r = 0; r < SIZE; r++) {
			for(int c = 0; c < SIZE; c++) {
				cells[r][c] = [[ImageGridCell alloc] init];
				cells[r][c].position = ccp(SQUARE_SIZE*r,SQUARE_SIZE*c);
				[self addChild:cells[r][c]];
			}
			rowLabels[r] = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(200, SQUARE_SIZE) hAlignment:kCCTextAlignmentLeft fontName:@"Mathlete-Bulky" fontSize:32.0f];
		}
	}
	return self;
}

@end
