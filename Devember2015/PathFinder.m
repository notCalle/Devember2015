//
//  PathFinder.m
//  Devember2015
//
//  Created by Calle Englund on 13/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "PathFinder.h"

@implementation PathFinder

-(id)initWithActor:(ActorSpriteNode *)actor map:(IsoTileMap *)map {
    self = [self init];
    if (self) {
        _actor = actor;
        _tileMap = map;
    }
    return self;
}

+(instancetype)finderFor:(ActorSpriteNode *)actor on:(IsoTileMap *)map {
    return [[PathFinder alloc] initWithActor:actor map:map];
}

-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there {
    return [self findPathTo:there from:(IsoTileNode *)_actor.parent];
}

-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there from:(IsoTileNode *)here {
    NSMutableArray<IsoTileNode *> *path = [NSMutableArray array];
    NSMutableDictionary<IsoTileNode *,NSNumber *> *pathCost = [NSMutableDictionary dictionary];
    NSMutableDictionary<IsoTileNode *,NSNumber *> *goalCost = [NSMutableDictionary dictionary];
    NSMutableSet<IsoTileNode *> *closedSet = [NSMutableSet set];
    NCPriorityQueue<IsoTileNode *> *openQueue = [NCPriorityQueue queueWithPriorities:goalCost];
    NSMutableDictionary<IsoTileNode *,IsoTileNode *> *cameFrom = [NSMutableDictionary dictionary];

    for (SKNode *node in _tileMap.children) {
        if ([node isKindOfClass:[IsoTileNode class]]) {
            pathCost[(IsoTileNode *)node] = [NSNumber numberWithDouble:CGFLOAT_MAX];
            goalCost[(IsoTileNode *)node] = [NSNumber numberWithDouble:CGFLOAT_MAX];
        }
    }
    [openQueue addObject:here];
    pathCost[here] = [NSNumber numberWithDouble:0.0];
    goalCost[here] = [NSNumber numberWithDouble:[_tileMap bestPathCostFrom:here to:there]];
    
    while (openQueue.count > 0) {
        IsoTileNode *current = openQueue.lastObject;
        if (current == there) {
            // reconstruct path
            [path addObject:current];
            while ((current = cameFrom[current])) {
                [path addObject:current];
            }
            break;
        } else {
            [openQueue removeLastObject];
            [closedSet addObject:current];
            for (IsoTileNode *neighbor in current.neighbors) {
                if ([closedSet containsObject:neighbor])
                    continue;

                double tentativePathCost = pathCost[current].doubleValue + [_actor costOfStepTo:neighbor from:current];

                if (![openQueue containsObject:neighbor]) {
                    [openQueue addObject:neighbor];
                } else if (tentativePathCost >= pathCost[neighbor].doubleValue) {
                    continue;
                }
                cameFrom[neighbor] = current;
                pathCost[neighbor] = [NSNumber numberWithDouble:tentativePathCost];
                goalCost[neighbor] = [NSNumber numberWithDouble:(tentativePathCost +
                                                                 [_tileMap bestPathCostFrom:neighbor to:there])];
            }
        }
    }
    return path;
}


@end
