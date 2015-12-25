//
//  IsoTileMap.h
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

@class IsoTile;
@class IsoTileNode;
@class NCPerlinNoise;

@interface IsoTileMap : SKSpriteNode {
    CGPoint _position;
    vector_int2 _centerTile;
    GKRandomSource *_random;
    CGFloat _minimum_cost;
}

@property NSArray<IsoTile *> *tiles;
@property NSMutableArray<NSMutableArray<IsoTileNode *> *> *map;
@property CGFloat gridsize;
@property NSInteger width;
@property NSInteger height;
@property vector_int2 centerTile;
@property(readonly) GKGridGraph *gridGraph;

-(instancetype)initWithTiles:(NSArray<IsoTile *> *)tiles width:(NSInteger)width height:(NSInteger)height;
-(IsoTileNode *)tileAt:(vector_int2)grid;
-(void)setTile:(NSInteger)index at:(vector_int2)grid;
-(void)addChild:(SKSpriteNode *)sprite toTileAt:(vector_int2)grid;
-(void)positionTile:(IsoTileNode *)sprite at:(vector_int2)grid;
-(void)repositionTiles;
-(vector_int2)gridAtLocation:(CGPoint)location;
-(CGFloat)bestPathCostFrom:(IsoTileNode *)here to:(IsoTileNode *)there;

-(void)randomizeMap;
-(void)randomizeMapUsingTiles:(NSRange)range;

@end
