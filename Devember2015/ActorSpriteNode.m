//
//  ActorSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ActorSpriteNode.h"

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

-(BOOL)move:(char)direction {
    IsoTileNode *newPlace = [self tileInDirection:direction];
    BOOL canStep = [self canStepTo:newPlace];
    if (canStep) {
        [self reParent:newPlace];
    }
    return canStep;
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

@end
