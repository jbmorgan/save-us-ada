//
//  ImageGameLayer.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLayer.h"

@class TalkingHead, DialogueQueue, ImageGrid;

@interface ImageGameLayer : GameLayer {
	ImageGrid *imageGrid;
}

-(void)gridCellPressed:(id)sender;

@end
