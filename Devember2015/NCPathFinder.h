//
//  PathFinder.h
//  Devember2015
//
//  Created by Calle Englund on 13/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "NCGraphNode.h"

@class NCPriorityQueue;
@class IsoTileMap;
@class IsoTileNode;
@class NCBodyComponent;

@interface NCPathFinder : NSObject {
    IsoTileMap *_tileMap;
    NCBodyComponent *_actor;
    NCPriorityQueue<IsoTileNode *> *_openQueue;
    NSMutableArray<IsoTileNode *> *_graph;
}

-initWithActor:(NCBodyComponent *)actor map:(IsoTileMap *)map;
+(instancetype)finderFor:(NCBodyComponent *)actor on:(IsoTileMap *)map;

-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there;
-(NSArray<IsoTileNode *> *)findPathTo:(IsoTileNode *)there from:(IsoTileNode *)here;

@end
