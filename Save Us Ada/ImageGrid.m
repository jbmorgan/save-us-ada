//
//  ImageGrid.m
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ImageGrid.h"
#import "ImageGridCell.h"
#import "GridState.h"

@implementation ImageGrid

-(id)init {
	if(self = [super init]) {
		
		NSArray *encodings = [NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:7],nil],
							  [NSArray arrayWithObjects:[NSNumber numberWithInt:6], [NSNumber numberWithInt:1], nil],
							  [NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:2], nil],
							  [NSArray arrayWithObjects:[NSNumber numberWithInt:4], [NSNumber numberWithInt:3], nil],
							  [NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil],
							  [NSArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:5], nil],
							  [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:6], nil],
							  nil];
		
		targetState = [[GridState alloc] initWithEncoding:encodings];
		
		NSMutableArray *menuItems = [NSMutableArray array];

		for(int r = 0; r < SIZE; r++) {
			for(int c = 0; c < SIZE; c++) {
				cells[r][c] = [[ImageGridCell alloc] init];
				cells[r][c].position = ccp(SQUARE_SIZE*r,SQUARE_SIZE*c);
				[self addChild:cells[r][c]];
				cells[r][c].button.position = ccp(SQUARE_SIZE*r-512,SQUARE_SIZE*c-384);
				[menuItems addObject:cells[r][c].button];
			}
			rowLabels[r] = [CCLabelTTF labelWithString:[targetState encodingForRow:r] dimensions:CGSizeMake(200, SQUARE_SIZE) hAlignment:kCCTextAlignmentLeft fontName:@"Mathlete-Bulky" fontSize:40.0f];
			rowLabels[r].position = ccp(600,SQUARE_SIZE*r);
			[self addChild:rowLabels[r] z:100];
		}
		
		buttons = [CCMenu menuWithArray:menuItems];
		[self addChild:buttons];
	}
	return self;
}

-(ImageGridCell *)cellAtPoint:(CGPoint)point {
	int row = (int)point.x/SQUARE_SIZE;
	int column = (int)point.y/SQUARE_SIZE;
	
	return cells[row][column];
}

-(void)touchAt:(CGPoint)point {
	[[self cellAtPoint:point] toggle];
}

@end
