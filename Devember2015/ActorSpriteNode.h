//
//  ActorSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

@import GameKit;
#import "ClutterSpriteNode.h"

typedef enum : NSUInteger {
    MOVE_EAST,
    MOVE_NORTHEAST,
    MOVE_NORTH,
    MOVE_NORTHWEST,
    MOVE_WEST,
    MOVE_SOUTHWEST,
    MOVE_SOUTH,
    MOVE_SOUTHEAST
} ActorMovementDirection;

@interface ActorSpriteNode : ClutterSpriteNode {
    CGFloat _direction;
    NSMutableArray<SKAction *> *_actions;
    ActorSpriteNode *_aggressor;
}

@property CGFloat stepHeight;
@property CGFloat stepSpeed;
@property CGFloat health;

-(IsoTileNode *)tileInDirection:(ActorMovementDirection)direction;
-(void)move:(ActorMovementDirection)direction;
-(void)moveTo:(IsoTileNode *)target;
-(void)moveTo:(IsoTileNode *)target maxSteps:(NSInteger)steps;
-(void)addAction:(SKAction *)action;
-(void)addActionStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;
-(BOOL)canStepTo:(IsoTileNode *)target;
-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;
-(CGFloat)costOfStepTo:(IsoTileNode *)target;
-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

-(void)update:(NSTimeInterval)currentTime;

-(void)didGetAttackedBy:(ActorSpriteNode *)aggressor;
-(void)didGetKilledBy:(ActorSpriteNode *)aggressor;
-(void)didKill:(ActorSpriteNode *)victim;

@end
