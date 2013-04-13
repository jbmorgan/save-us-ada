//
//  GridState.h
//  Save Us Ada
//
//  Created by Jon Morgan on 4/13/13.
//
//

#import <Foundation/Foundation.h>
#define SIZE 7

@interface GridState : NSObject {
	NSArray *encodings[SIZE];
	BOOL state[SIZE][SIZE];
}

-(id)initWithEncoding:(NSArray *)encodedRows;
-(NSString *)encodingForRow:(int)row;

@end
