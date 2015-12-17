//
//  ActorSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ActorSpriteNode.h"
#import "NCPathFinder.h"

@implementation ActorSpriteNode

-(void)reParent:(IsoTileNode *)newParent {
    if (newParent) {
        if (self.parent) {
            [self removeFromParent];
        }
        self.position = CGPointMake(0.0, (newParent.tile.stepHeight) * newParent.size.width / 2.0);
        self.zPosition = newParent.zPosition;
        [newParent addChild:self];
    }
}

-(IsoTileNode *)tileInDirection:(char)direction {
    IsoTileNode *currentPlace = (IsoTileNode *)[self parent];
    IsoTileNode *newPlace = nil;
    switch (direction) {
        case 'N':
            newPlace = currentPlace.north;
            break;
        case 'S':
            newPlace = currentPlace.south;
            break;
        case 'W':
            newPlace = currentPlace.west;
            break;
        case 'E':
            newPlace = currentPlace.east;
            break;
    }
    return newPlace;
}

-(void)move:(char)direction {
    [self addAction:[SKAction runBlock:^(void) {
        IsoTileNode *target = [self tileInDirection:direction];
        BOOL canStep = [self canStepTo:target];
        if (canStep) {
            [self addActionStepTo:target from:(IsoTileNode *)self.parent];
        }
    }]];
}

-(void)moveTo:(IsoTileNode *)target {
    NCPathFinder *pathFinder = [NCPathFinder finderFor:self on:(IsoTileMap *)target.parent];
    NSArray<IsoTileNode *> *path = [pathFinder findPathTo:target];
    
    if (path) {
        for (IsoTileNode *tile in path) {
            if (tile.cameFrom) {
                [self addActionStepTo:tile from:(IsoTileNode *)tile.cameFrom];
            }
        }
    }
}

-(void)addAction:(SKAction *)action {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    [_actions addObject:action];
}

-(void)addActionStepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    CGVector smoothMovement = CGVectorMake(target.position.x - here.position.x,
                                           target.position.y - here.position.y);
    CGFloat stepCost = [self costOfStepTo:target from:here];
    
    target.color = [NSColor redColor];
    target.colorBlendFactor = 1.0;
    [self addAction:[SKAction moveBy:smoothMovement duration:0.2*stepCost]];
    [self addAction:[SKAction runBlock:^(void){
        [self reParent:target];
        [target runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:1.0]];
    }]];
}

-(BOOL)canStepTo:(IsoTileNode *)target {
    return [self canStepTo:target from:(IsoTileNode *)self.parent];
}

-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    if (target != nil &&
        (target == here.north ||
         target == here.south ||
         target == here.west  ||
         target == here.east))
    {
        CGFloat stepHeight = fabs(target.tile.stepHeight - here.tile.stepHeight);
        return (stepHeight <= _stepHeight);
    }
    return NO;
}

-(CGFloat)costOfStepTo:(IsoTileNode *)target {
    return [self costOfStepTo:target from:(IsoTileNode *)self.parent];
}

-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    if ([self canStepTo:target from:here]) {
        CGFloat baseCost = (target.tile.stepCost + here.tile.stepCost) / 2.0;
        CGFloat stepHeight = target.tile.stepHeight - here.tile.stepHeight;
        return baseCost + stepHeight * stepHeight;
    }
    return CGFLOAT_MAX;
}

-(void)update:(NSTimeInterval)currentTime {
    if (_actions.count && ![self hasActions]) {
        [self runAction:[SKAction sequence:_actions]];
        [_actions removeAllObjects];
    }
}

@end
