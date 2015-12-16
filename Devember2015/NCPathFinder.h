//
//  PathFinder.h
//  Devember2015
//
//  Created by Calle Englund on 13/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "NCPriorityQueue.h"
#import "NCGraphNode.h"
#import "IsoTileMap.h"
#import "ActorSpriteNode.h"

@interface NCPathFinder : NSObject {
    IsoTileMap *_tileMap;
    ActorSpriteNode *_actor;
    NCPriorityQueue<IsoTileNode *> *_openQueue;
    NSMutableArray<IsoTileNode *> *_graph;
}

-initWithActor:(ActorSpriteNode *)actor map:(IsoTileMap *)map;
+(instancetype)finderFor:(ActorSpriteNode *)actor on:(IsoTileMap *)map;

-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there;
-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there from:(IsoTileNode *)here;

@end
