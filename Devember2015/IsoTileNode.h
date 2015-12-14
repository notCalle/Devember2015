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

@interface IsoTileNode : SKSpriteNode

@property(nonatomic) IsoTileNode *north;
@property(nonatomic) IsoTileNode *south;
@property(nonatomic) IsoTileNode *west;
@property(nonatomic) IsoTileNode *east;
@property(nonatomic) IsoTile *tile;
@property vector_int2 gridPosition;

-(instancetype)initWithTile:(IsoTile *)tile;
-(NSArray<IsoTileNode *> *)neighbors;
-(NSString *)gridS;

@end
