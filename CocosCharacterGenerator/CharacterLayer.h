//
//  CharacterLayer.h
//  Mappin
//
//  Created by Cem Olcay on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CharacterLayer : CCLayer {
	CCSpriteBatchNode *spriteSheet;
	CCSprite *animatedSprite;
	CCAction *walkLeft;
	CCAction *walkRight;
	CCAction *walkDown;
	CCAction *walkUp;
}

@property (nonatomic, retain) CCSpriteBatchNode *spriteSheet;
@property (nonatomic, retain) CCSprite *animatedSprite;
@property (nonatomic, retain) CCAction *walkLeft;
@property (nonatomic, retain) CCAction *walkRight;
@property (nonatomic, retain) CCAction *walkDown;
@property (nonatomic, retain) CCAction *walkUp;

-(void)setAnimatedSpritePosition:(CGPoint)pos;
-(id)init;

@end
