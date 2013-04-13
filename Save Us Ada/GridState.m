//
//  GridState.m
//  Save Us Ada
//
//  Created by Jon Morgan on 4/13/13.
//
//

#import "GridState.h"

@implementation GridState

-(id)initWithEncoding:(NSArray *)encodedRows {
	if(self = [super init]) {
		
		if(encodedRows.count != SIZE) {
			NSLog(@"Should have 7 rows but doesn't.");
			return nil;
		}
		
		int rowNumber = 0;
		
		for(NSArray *encodedRow in encodedRows) {
			
			//save the encoding for this row
			encodings[rowNumber] = encodedRow;
			
			//verify that the row sums to 7
			int sumForRow = 0;
			
			for(NSNumber *n in encodedRow) {
				sumForRow += [n intValue];
			}
			
			if(sumForRow != SIZE) {
				NSLog(@"Row should sum to 7 but doesn't.");
				return nil;
			}
			
			//convert the encoding to an array of booleans
			BOOL currentRunIsOn = NO; //is the current run of squares that are ON or OFF?
			int currentPositionInRow = 0;
			
			for(NSNumber *n in encodedRow) {
				for(int i = 0; i < [n intValue]; i++) {
					state[rowNumber][currentPositionInRow+i] = currentRunIsOn;
				}
				currentPositionInRow += [n intValue];
				currentRunIsOn = !currentRunIsOn;
			}
				
			//increment the row number (duh)
			rowNumber++;
		}
	}
	return self;
}

-(NSString *)encodingForRow:(int)row {
	NSString *returnString = @"";
	
	for(NSNumber *n in encodings[row]) {
		returnString = [NSString stringWithFormat:@"%@%i, ", returnString, [n intValue]];
	}
	return [returnString substringToIndex:returnString.length-2];
}

-(BOOL)stateforRow:(int)r andCol:(int)c {
	return state[r][c];
}

@end
