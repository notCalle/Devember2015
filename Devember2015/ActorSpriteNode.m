//
//  ActorSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ActorSpriteNode.h"
#import "NCPathFinder.h"
#import "GameScene.h"
#import "IsoTIleNode.h"

@implementation ActorSpriteNode

-(void)reParent:(IsoTileNode *)newParent {
    IsoTileNode *currentParent = (IsoTileNode *)self.parent;
    GameScene *scene = (GameScene *)newParent.scene;
    
    if (newParent) {
        
        for (ActorSpriteNode *child in newParent.children) {
            if ([child isKindOfClass:[ActorSpriteNode class]] &&
                ![child isKindOfClass:[self class]]) {
                [child didGetAttackedBy:self];
                newParent = currentParent;
                break;
            }
        }
        
        if (newParent == currentParent.east) {
            _direction = MOVE_EAST;
        } else if (newParent == currentParent.northEast) {
            _direction = MOVE_NORTHEAST;
        } else if (newParent == currentParent.north) {
            _direction = MOVE_NORTH;
        } else if (newParent == currentParent.northWest) {
            _direction = MOVE_NORTHWEST;
        } else if (newParent == currentParent.west) {
            _direction = MOVE_WEST;
        } else if (newParent == currentParent.southWest) {
            _direction = MOVE_SOUTHWEST;
        } else if (newParent == currentParent.south) {
            _direction = MOVE_SOUTH;
        } else if (newParent == currentParent.southEast) {
            _direction = MOVE_SOUTHEAST;
        }
    } else {
        // moving to limbo, so we remove ourself from the scene
        [scene.actors removeObject:self];
    }
    [super reParent:newParent];
}

-(void)addActionStepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    CGVector smoothMovement = CGVectorMake((target.position.x - here.position.x) / 2.0,
                                           (target.position.y - here.position.y) / 2.0);
    CGFloat stepCost = [self costOfStepTo:target from:here];
    
    target.color = [NSColor redColor];
    target.colorBlendFactor = 1.0;
    [target runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:1.0]];
    [self addMovement:[SKAction moveBy:smoothMovement duration:0.1*stepCost/_stepSpeed]];
    [self addMovement:[SKAction runBlock:^(void){
        [self reParent:target];
        self.position = CGPointMake(self.position.x - smoothMovement.dx, self.position.y - smoothMovement.dy);
    }]];
    [self addMovement:[SKAction moveBy:smoothMovement duration:0.1*stepCost/_stepSpeed]];
}

-(void)update:(NSTimeInterval)currentTime {
    if (_actions.count && ![self hasActions]) {
        [self runAction:[SKAction sequence:_actions]];
        [_actions removeAllObjects];
    }
}

-(void)didGetKilledBy:(ActorSpriteNode *)aggressor {
    GameScene *scene = (GameScene *)self.scene;
    [scene.console addText:[NSString stringWithFormat:@"%@ was killed by %@", self.name, aggressor.name]];
    [self reParent:nil]; // go to limbo
    [aggressor didKill:self];
}


@end
