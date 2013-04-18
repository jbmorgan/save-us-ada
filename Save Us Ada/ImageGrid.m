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

//initialize the grid with a specific pattern
-(id)initWithEncoding:(NSArray *)enc {
	if(self = [super init]) {
		
		targetState = [[GridState alloc] initWithEncoding:enc];
		
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
			rowLabels[r].position = ccp(560, 6*SQUARE_SIZE-SQUARE_SIZE*r);
			[self addChild:rowLabels[r] z:100];
		}
		
		buttons = [CCMenu menuWithArray:menuItems];
		[self addChild:buttons];
	}
	return self;
}

//resets the grid's target state and updates the row labels accordingly
-(void)setEncoding:(NSArray *)enc {
	GridState *newState = [[GridState alloc] initWithEncoding:[enc copy]];
	targetState = newState;
	for(int r = 0; r < SIZE; r++) {
		for(int c = 0; c < SIZE; c++) {
			[cells[r][c] reset];
		}
		[rowLabels[r] setString:[targetState encodingForRow:r]];
	}
}

//whether the state of the grid matches its target state
-(BOOL)matchesTarget {
	for(int r = 0; r < SIZE; r++)
		for(int c = 0; c < SIZE; c++)
			if(cells[c][SIZE-1-r].selected != [targetState stateforRow:r andCol:c])
				return NO;
	return YES;
}

//returns the index of one of the incorrect rows in the image
//used for giving hints to the player
-(int)randomIncorrectRow {
	NSMutableArray *incorrectRows = [NSMutableArray arrayWithCapacity:SIZE];
	
	for(int r = 0; r < SIZE; r++) {
		for(int c = 0; c < SIZE; c++) {
			if(cells[c][SIZE-1-r].selected != [targetState stateforRow:r andCol:c]) {
				[incorrectRows addObject:[NSNumber numberWithInt:r]];
				break;
			}
		}
	}

	if(incorrectRows.count > 0) {
		NSNumber *rowNumber = incorrectRows[arc4random_uniform(incorrectRows.count)];
		return rowNumber.intValue;
	} else {
		return -1;
	}
}

-(int)countOfIncorrectSquaresInRow:(int)r {
	
	int incorrectSquares = 0;
	
	for(int c = 0; c < SIZE; c++) {
		if(cells[c][SIZE-1-r].selected != [targetState stateforRow:r andCol:c]) {
			incorrectSquares++;
		}
	}
	return incorrectSquares;
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
