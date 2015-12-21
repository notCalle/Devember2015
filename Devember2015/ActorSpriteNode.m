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

-(IsoTileNode *)tileInDirection:(ActorMovementDirection)direction {
    IsoTileNode *currentPlace = (IsoTileNode *)[self parent];
    IsoTileNode *newPlace = nil;
    switch (direction) {
        case MOVE_NORTH:
            newPlace = currentPlace.north;
            break;
        case MOVE_SOUTH:
            newPlace = currentPlace.south;
            break;
        case MOVE_WEST:
            newPlace = currentPlace.west;
            break;
        case MOVE_EAST:
            newPlace = currentPlace.east;
            break;
    }
    return newPlace;
}

-(void)reParent:(IsoTileNode *)newParent {
    IsoTileNode *currentParent = (IsoTileNode *)self.parent;

    for (ActorSpriteNode *child in newParent.children) {
        if ([child isKindOfClass:[ActorSpriteNode class]] &&
            ![child isKindOfClass:[self class]]) {
            [child didGetAttackedBy:self];
            newParent = currentParent;
            break;
        }
    }

    if (newParent == currentParent.north) {
        _direction = MOVE_NORTH;
    } else if (newParent == currentParent.south) {
        _direction = MOVE_SOUTH;
    } else if (newParent == currentParent.west) {
        _direction = MOVE_WEST;
    } else if (newParent == currentParent.east) {
        _direction = MOVE_EAST;
    }
    [super reParent:newParent];
}

-(void)move:(ActorMovementDirection)direction {
    [self addAction:[SKAction runBlock:^(void) {
        IsoTileNode *target = [self tileInDirection:direction];
        BOOL canStep = [self canStepTo:target];
        if (canStep) {
            [self addActionStepTo:target from:(IsoTileNode *)self.parent];
        }
    }]];
}

-(void)moveTo:(IsoTileNode *)target {
    [self moveTo:target maxSteps:NSIntegerMax];
}

-(void)moveTo:(IsoTileNode *)target maxSteps:(NSInteger)steps {
    NCPathFinder *pathFinder = [NCPathFinder finderFor:self on:(IsoTileMap *)target.parent];
    NSArray<IsoTileNode *> *path = [pathFinder findPathTo:target];
    
    if (path) {
        if (steps > path.count - 1) {
            steps = path.count - 1;
        }
        for (IsoTileNode *tile in [path subarrayWithRange:NSMakeRange(1,steps)]) {
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
    CGVector smoothMovement = CGVectorMake((target.position.x - here.position.x) / 2.0,
                                           (target.position.y - here.position.y) / 2.0);
    CGFloat stepCost = [self costOfStepTo:target from:here];
    
    target.color = [NSColor redColor];
    target.colorBlendFactor = 1.0;
    [self addAction:[SKAction moveBy:smoothMovement duration:0.1*stepCost/_stepSpeed]];
    [self addAction:[SKAction runBlock:^(void){
        [self reParent:target];
        self.position = CGPointMake(self.position.x - smoothMovement.dx, self.position.y - smoothMovement.dy);
        [target runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:1.0]];
    }]];
    [self addAction:[SKAction moveBy:smoothMovement duration:0.1*stepCost/_stepSpeed]];
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
        CGFloat baseCost = (target.stepCost + here.stepCost) / 2.0;
        CGFloat stepHeight = target.stepHeight - here.stepHeight;
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

-(void)didGetAttackedBy:(ActorSpriteNode *)aggressor {
    // Remember our most current enemy
    _aggressor = aggressor;
    _health -= 1.0;
    self.color = [NSColor redColor];
    self.colorBlendFactor = 1.0;
    [self runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:0.5]];
}

@end
