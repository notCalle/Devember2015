//
//  ActorSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ActorSpriteNode.h"

@implementation ActorSpriteNode

-(BOOL)reParent:(IsoTileNode *)newParent {
    
    if (newParent) {
        if (self.parent) {
            IsoTileNode *oldParent = (IsoTileNode *)self.parent;
            CGFloat stepHeight = fabs(newParent.tile.stepHeight - oldParent.tile.stepHeight);
            if (stepHeight <= _stepHeight) {
                [self removeFromParent];
                self.position = CGPointMake(0.0, (newParent.tile.stepHeight + 1.0) * newParent.size.width / 4.0);
                self.zPosition = newParent.zPosition;
                [newParent addChild:self];
                return YES;
            }
        } else {
            self.position = CGPointMake(0.0, (newParent.tile.stepHeight + 1.0) * newParent.size.width / 4.0);
            self.zPosition = newParent.zPosition;
            [newParent addChild:self];
        }
    }
    return NO;
}

-(BOOL)move:(char)direction {
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
    return [self reParent:newPlace];
}

@end
