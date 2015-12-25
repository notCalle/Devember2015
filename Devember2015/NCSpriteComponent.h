//
//  NCSpriteComponent.h
//  Devember2015
//
//  Created by Calle Englund on 25/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import "NCMovementDirection.h"

@class NCSpriteNode;
@class IsoTileNode;

@interface NCSpriteComponent : GKComponent

@property NSMutableArray<dispatch_block_t> *movement;
@property NCSpriteNode *sprite;
@property CGFloat direction;
@property CGFloat stepHeight;
@property CGFloat stepSpeed;

-(instancetype)initWithSprite:(NCSpriteNode *)sprite;

-(void)step:(NCMovementDirection)direction;
-(void)stepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

-(BOOL)canStepTo:(IsoTileNode *)target;
-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;
-(CGFloat)costOfStepTo:(IsoTileNode *)target;
-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

-(void)moveTo:(IsoTileNode *)target;
-(void)moveTo:(IsoTileNode *)target maxSteps:(NSInteger)steps;

@end
