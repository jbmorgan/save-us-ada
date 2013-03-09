//
//  CountingGameLayer.h
//  Save Us Ada
//
//  Created by Jonathan Morgan on 2/26/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CountingGameLayer : CCLayer {
    int selectedTotal;
    int targetTotal;
	CCMenuItem	*sixteenCard,
				*eightCard,
				*fourCard,
				*twoCard,
				*oneCard;
	CCLabelTTF	*selectedTotalLabel;
	CCLabelTTF	*targetTotalLabel;
	BOOL cards[5];
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)cardPressed:(id)sender;

@end
