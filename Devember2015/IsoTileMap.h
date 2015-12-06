//
//  IsoTileMap.h
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "ITSpriteNode.h"

@interface IsoTileMap : ITSpriteNode {
    CGPoint _position;
    CGPoint _centerTile;
}

@property NSArray<NSString *> *tiles;
@property NSMutableArray *map;
@property CGFloat gridsize;
@property NSInteger width;
@property NSInteger height;
@property CGPoint centerTile;

- (instancetype)initWithTiles:(NSArray<NSString *> *)tiles mapSize:(CGSize)size;
- (ITSpriteNode *)tileAt:(CGPoint)grid;
- (void)setTile:(NSInteger)index at:(CGPoint)grid;
- (void)addChild:(ITSpriteNode *)sprite toTileAt:(CGPoint)grid;

- (void)positionSprite:(ITSpriteNode *)sprite at:(CGPoint)grid;

- (void)repositionTiles;

- (CGPoint)gridAtLocation:(CGPoint)location;

@end
