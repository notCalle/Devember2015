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
    GKGridGraph *gridGraph = [GKGridGraph graphFromGridStartingAt:(vector_int2){0,0}
                                                            width:(int)_tileMap.width
                                                           height:(int)_tileMap.height
                                                 diagonalsAllowed:NO];
    NSMutableArray<IsoTileNode *> *path = nil;
    
    while (path == nil) {
        GKGridGraphNode *hereNode = [gridGraph nodeAtGridPosition:here.gridPosition];
        GKGridGraphNode *thereNode = [gridGraph nodeAtGridPosition:there.gridPosition];

        if (thereNode && hereNode) {
            NSArray<GKGridGraphNode *> *gridPath = [gridGraph findPathFromNode:hereNode toNode:thereNode];
            IsoTileNode *previousNode = nil;
            path = [NSMutableArray arrayWithCapacity:gridPath.count];
            
            for (GKGridGraphNode *graphNode in gridPath) {
                IsoTileNode *tileNode = [_tileMap tileAt:graphNode.gridPosition];
                
                if (previousNode == nil ||
                    [_actor canStepTo:tileNode from:previousNode])
                {
                    [path addObject:tileNode];
                } else {
                    [gridGraph removeNodes:@[graphNode]];
                    path = nil;
                    break;
                }
                previousNode = tileNode;
            }
        } else
            break;
    }
    return path;
}

@end
