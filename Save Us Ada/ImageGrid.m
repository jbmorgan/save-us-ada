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


-(id)initWithWidth:(int)w andHeight:(int)h {
	if(self = [super init]) {
		_width = w;
		_height = h;
		
		_columns = [NSMutableArray arrayWithCapacity:_width];
		
		for(int i = 0; i < _width; i++) {
			NSMutableArray *column = [NSMutableArray arrayWithCapacity:_height];
			
			for(int row = 0; row < _height; row++) {
				[column addObject:[[ImageGridCell alloc] init]];
			}
			
			[_columns addObject:column];
		}
	}
	return self;
}

@end
