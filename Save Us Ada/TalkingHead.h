//
//  TalkingHead.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TalkingHead : CCNode {
    
}

@property (readonly, retain) CCSprite *sprite;

-(id)initWithSpriteNamed:(NSString *)name;
-(void)say:(NSString *)text;

@end
