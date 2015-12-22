//
//  ITSpriteNode.h
//  Devember2015
//
//  Created by Calle Englund on 06/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>
#import "IsoTile.h"
#import "NCGraphNode.h"

@interface IsoTileNode : SKSpriteNode <NCGraphNode>

@property(nonatomic) IsoTileNode *east;
@property(nonatomic) IsoTileNode *northEast;
@property(nonatomic) IsoTileNode *north;
@property(nonatomic) IsoTileNode *northWest;
@property(nonatomic) IsoTileNode *west;
@property(nonatomic) IsoTileNode *southWest;
@property(nonatomic) IsoTileNode *south;
@property(nonatomic) IsoTileNode *southEast;
@property(nonatomic) IsoTile *tile;
@property(nonatomic) vector_int2 gridPosition;
@property CGFloat stepHeight;
@property CGFloat stepCost;

-(instancetype)initWithTile:(IsoTile *)tile;

@end
