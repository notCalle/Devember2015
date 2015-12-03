//
//  IsoTileMap.h
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface IsoTileMap : NSObject {
    CGPoint _position;
    CGPoint _centerTile;
}

@property NSArray<NSString *> *tiles;
@property NSMutableArray *map;
@property CGFloat gridsize;
@property NSInteger width;
@property NSInteger height;
@property CGPoint position;
@property CGPoint centerTile;

- (instancetype)initWithTiles:(NSArray<NSString *> *)tiles mapSize:(CGSize)size;
- (SKSpriteNode *)tileAt:(CGPoint)grid;
- (void)setTile:(NSInteger)index at:(CGPoint)grid;

- (void)repositionTiles;
- (void)addAsChildOf:(SKScene *)theScene;

- (CGPoint)gridAtLocation:(CGPoint)location;

@end
