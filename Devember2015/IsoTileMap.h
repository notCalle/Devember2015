//
//  IsoTileMap.h
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface IsoTileMap : NSObject

@property NSArray<NSString *> *tiles;
@property NSMutableArray *map;
@property CGFloat gridsize;
@property NSInteger width;
@property NSInteger height;

- (instancetype)initWithTiles:(NSArray<NSString *> *)tiles mapSize:(CGSize)size;
- (SKSpriteNode *)tileAt:(CGPoint)position;
- (void)setTile:(NSInteger)index at:(CGPoint)position;

+ (CGPoint)isometric:(CGPoint)cartesian;
+ (CGPoint)cartesian:(CGPoint)isometric;

@end
