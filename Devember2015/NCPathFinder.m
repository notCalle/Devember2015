//
//  PathFinder.m
//  Devember2015
//
//  Created by Calle Englund on 13/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCPathFinder.h"

@implementation NCPathFinder

-(id)initWithActor:(ActorSpriteNode *)actor map:(IsoTileMap *)map {
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

+(instancetype)finderFor:(ActorSpriteNode *)actor on:(IsoTileMap *)map {
    return [[NCPathFinder alloc] initWithActor:actor map:map];
}

-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there {
    return [self findPathTo:there from:(IsoTileNode *)_actor.parent];
}

-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there from:(IsoTileNode *)here {
    NSMutableArray<IsoTileNode *> *path = [NSMutableArray array];

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
            
            current.color=[NSColor blackColor];

            for (IsoTileNode *neighbor in current.neighbors) {
                if (neighbor.visited)
                    continue;
                if (![_actor canStepTo:neighbor from:current])
                    continue;

                neighbor.color = [NSColor blueColor];
                neighbor.colorBlendFactor = 1.0;
                [neighbor runAction:[SKAction colorizeWithColorBlendFactor:0.0 duration:5.0]];

                CGFloat tentativePathCost = current.bestPathCost + [_actor costOfStepTo:neighbor from:current];

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
    for (IsoTileNode *tile in path) {
        tile.color = [NSColor redColor];
    }
    return path;
}


@end
