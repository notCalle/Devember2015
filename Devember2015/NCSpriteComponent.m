//
//  NCSpriteComponent.m
//  Devember2015
//
//  Created by Calle Englund on 25/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCSpriteComponent.h"
#import "NCSPriteNode.h"
#import "IsoTileNode.h"
#import "IsoTile.h"
#import "NCPathFinder.h"

@implementation NCSpriteComponent

-(instancetype)initWithSprite:(NCSpriteNode *)sprite {
    self = [self init];
    if (self) {
        _sprite = sprite;
    }
    return self;
}

#pragma mark - movement

-(void)step:(NCMovementDirection)direction {
    IsoTileNode *here = _sprite.tile;
    IsoTileNode *target = [here tileInDirection:direction];
    if ([self canStepTo:target]) {
        [self stepTo:target from:here];
    }
}

-(void)stepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    
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
                [self stepTo:tile from:(IsoTileNode *)tile.cameFrom];
            }
        }
    }
}

-(BOOL)canStepTo:(IsoTileNode *)target {
    return [self canStepTo:target from:(IsoTileNode *)_sprite.tile];
}

-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    if (target != nil &&
        (target == here.east      ||
         target == here.northEast ||
         target == here.north     ||
         target == here.northWest ||
         target == here.west      ||
         target == here.southWest ||
         target == here.south     ||
         target == here.southEast))
    {
        CGFloat stepHeight = fabs(target.tile.stepHeight - here.tile.stepHeight);
        return (stepHeight <= _stepHeight);
    }
    return NO;
}

-(CGFloat)costOfStepTo:(IsoTileNode *)target {
    return [self costOfStepTo:target from:(IsoTileNode *)_sprite.tile];
}

-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here {
    if ([self canStepTo:target from:here]) {
        CGFloat xDelta = abs(target.gridPosition.x - here.gridPosition.x);
        CGFloat yDelta = abs(target.gridPosition.y - here.gridPosition.y);
        CGFloat distance = (xDelta > yDelta) ? (xDelta + yDelta/2.0) : (xDelta/2.0 + yDelta);
        CGFloat baseCost = (target.stepCost + here.stepCost) / 2.0;
        CGFloat stepHeight = target.stepHeight - here.stepHeight;
        return baseCost*(distance + stepHeight);
    }
    return CGFLOAT_MAX;
}

@end
