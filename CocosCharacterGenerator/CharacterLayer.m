//
//  CharacterLayer.m
//  Mappin
//
//  Created by Cem Olcay on 12/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CharacterLayer.h"

//Vertical row numbers in sheet
#define sheetVerticalLines 3

//Size of one tile in sheet
#define sheetTileWidth 32
#define sheetTileHeight 32

//Horizontal animaton row number (starts from 0)
#define sheetDownLineNumber 0
#define sheetLeftLineNumber 1
#define sheetRightLineNumber 2
#define sheetUpLineNumber 3

@implementation CharacterLayer

@synthesize spriteSheet;
@synthesize animatedSprite;
@synthesize walkLeft;
@synthesize walkRight;
@synthesize walkDown;
@synthesize walkUp;

-(id)initWithSheetName:(NSString*)sheetName
{
	if ((self = [super init])) {
		
		spriteSheet  = [CCSpriteBatchNode batchNodeWithFile:sheetName];
		[self addChild:spriteSheet];
		
		self.animatedSprite = [CCSprite spriteWithTexture:spriteSheet.texture rect:CGRectMake(0, 0, sheetTileWidth, sheetTileHeight)];
		[self addChild:animatedSprite];
		
		NSMutableArray *frames = [NSMutableArray new];
		
		for (int x = 0; x < sheetVerticalLines; x++) {
			CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:spriteSheet.texture rect:CGRectMake(x*sheetTileWidth, sheetTileHeight*sheetDownLineNumber, sheetTileWidth, sheetTileHeight)];
			[frames addObject:frame];
		}
		self.walkDown = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:frames delay:0.05]]];
		[frames removeAllObjects];
		
		for (int x = 0; x < sheetVerticalLines; x++) {
			CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:spriteSheet.texture rect:CGRectMake(x*sheetTileWidth, sheetTileHeight*sheetLeftLineNumber, sheetTileWidth, sheetTileHeight)];
			[frames addObject:frame];
		}
		self.walkLeft = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:frames delay:0.05]]];
		[frames removeAllObjects];
		
		for (int x = 0; x < sheetVerticalLines; x++) {
			CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:spriteSheet.texture rect:CGRectMake(x*sheetTileWidth, sheetTileHeight*sheetUpLineNumber, sheetTileWidth, sheetTileHeight)];
			[frames addObject:frame];
		}
		self.walkUp = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:frames delay:0.05]]];
		[frames removeAllObjects];
		
		for (int x = 0; x < sheetVerticalLines; x++) {
			CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:spriteSheet.texture rect:CGRectMake(x*sheetTileWidth, sheetTileHeight*sheetRightLineNumber, sheetTileWidth, sheetTileHeight)];
			[frames addObject:frame];
		}
		self.walkRight = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:frames delay:0.05]]];
		
		[frames removeAllObjects];
		[frames release];
	}
	
	return self;
}

-(void)setAnimatedSpritePosition:(CGPoint)pos
{
	self.animatedSprite.position = CGPointMake(pos.x, pos.y);
}

-(void)dealloc
{
	[spriteSheet release];
	[animatedSprite release];
	[walkLeft release];
	[walkRight release];
	[walkUp release];
	[walkDown release];
	[super dealloc];
}

@end
