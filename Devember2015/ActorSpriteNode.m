//
//  ActorSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 07/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ActorSpriteNode.h"

@implementation ActorSpriteNode

-(BOOL)reParent:(ITSpriteNode *)newParent {
    
    if (newParent) {
        if (self.parent) {
            ITSpriteNode *oldParent = (ITSpriteNode *)self.parent;
            CGFloat stepHeight = fabs((newParent.size.height - oldParent.size.height) * 2.0 / oldParent.size.width);
            if (stepHeight <= _stepHeight) {
                [self removeFromParent];
                self.position = CGPointMake(0.0, newParent.size.height - newParent.size.width / 2.0);
                [newParent addChild:self];
                return YES;
            }
        } else {
            self.position = CGPointMake(0.0, newParent.size.height - newParent.size.width / 2.0);
            self.zPosition = newParent.zPosition;
            [newParent addChild:self];
        }
    }
    return NO;
}

-(BOOL)move:(char)direction {
    ITSpriteNode *currentPlace = (ITSpriteNode *)[self parent];
    ITSpriteNode *newPlace = nil;
    
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
