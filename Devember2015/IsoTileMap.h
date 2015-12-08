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
#import "IsoTileNode.h"

@interface IsoTileMap : SKSpriteNode {
    CGPoint _position;
    CGPoint _centerTile;
    GKRandomSource *_random;
}

@property NSArray<IsoTile *> *tiles;
@property NSMutableArray<NSMutableArray<IsoTileNode *> *> *map;
@property CGFloat gridsize;
@property NSInteger width;
@property NSInteger height;
@property CGPoint centerTile;

- (instancetype)initWithTiles:(NSArray<IsoTile *> *)tiles mapSize:(CGSize)size;
- (IsoTileNode *)tileAt:(CGPoint)grid;
- (void)setTile:(NSInteger)index at:(CGPoint)grid;
- (void)addChild:(SKSpriteNode *)sprite toTileAt:(CGPoint)grid;
- (void)positionTile:(IsoTileNode *)sprite at:(CGPoint)grid;
- (void)repositionTiles;
- (CGPoint)gridAtLocation:(CGPoint)location;

- (void)randomizeMap;

@end
