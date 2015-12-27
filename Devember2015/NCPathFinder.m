//
//  PathFinder.m
//  Devember2015
//
//  Created by Calle Englund on 13/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCPathFinder.h"
#import "NCPriorityQueue.h"
#import "IsoTileMap.h"
#import "IsoTileNode.h"
#import "NCActorEntity.h"
#import "NCBodyComponent.h"
#import "NCSpriteNode.h"

@implementation NCPathFinder

-(id)initWithActor:(NCActorEntity *)actor map:(IsoTileMap *)map {
    self = [self init];
    if (self) {
        _actor = actor;
        _tileMap = map;
        _openQueue = [NCPriorityQueue queue];
        for (IsoTileNode *node in _tileMap.children) {
            if ([node isKindOfClass:[IsoTileNode class]]) {
                node.estimatedGoalCost = CGFLOAT_MAX;
                node.bestPathCost = CGFLOAT_MAX;
                node.visited = NO;
                node.cameFrom = nil;
            }
        }
    }
    return self;
}

+(instancetype)finderFor:(NCActorEntity *)actor on:(IsoTileMap *)map {
    return [[NCPathFinder alloc] initWithActor:actor map:map];
}

-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there {
    return [self findPathTo:there from:(IsoTileNode *)_actor.body.sprite.tile];
}

-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there from:(IsoTileNode *)here {
    NSMutableArray<IsoTileNode *> *path = [NSMutableArray array];
    NCBodyComponent *body = _actor.body;

    [_openQueue addObject:here];
    here.bestPathCost = 0.0;
    here.estimatedGoalCost = [_tileMap bestPathCostFrom:here to:there];
    
    while (_openQueue.count > 0) {
        IsoTileNode *current = _openQueue.lastObject;
        if (current == there) {
            [path addObject:current];
            while ((current = (IsoTileNode *)current.cameFrom)) {
                [path insertObject:current atIndex:0];
            }
            break;
        } else {
            [_openQueue removeLastObject];
            current.visited = YES;
            
            for (IsoTileNode *neighbor in current.neighbors) {
                if (neighbor.visited)
                    continue;
                if (![body canStepTo:neighbor from:current])
                    continue;

                CGFloat tentativePathCost = current.bestPathCost + [body costOfStepTo:neighbor from:current];

                if (tentativePathCost < neighbor.bestPathCost) {
                    neighbor.cameFrom = current;
                    neighbor.bestPathCost = tentativePathCost;
                    neighbor.estimatedGoalCost = tentativePathCost + [_tileMap bestPathCostFrom:neighbor to:there];
                    [_openQueue removeObject:neighbor];
                }
                if (![_openQueue containsObject:neighbor])
                    [_openQueue addObject:neighbor];
            }
        }
    }
    return path;
}


@end
