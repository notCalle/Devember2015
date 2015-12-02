//
//  IsoTileMap.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTileMap.h"

@implementation IsoTileMap

- (instancetype)initWithTiles:(NSArray<NSString *> *)tiles mapSize:(CGSize)size {
    NSInteger row;
    
    self = [self init];
    if (self) {
        _tiles = tiles;
        _map = [NSMutableArray arrayWithCapacity:size.height];
        
        _width = (NSInteger)size.width;
        _height = (NSInteger)size.height;

        for (row = 0; row < _height; row++) {
            _map[row] = [NSMutableArray arrayWithCapacity:_width];
        }
    }
    return self;
}

- (SKSpriteNode *)tileAt:(CGPoint)position {
    return _map[(NSInteger)position.y][(NSInteger)position.x];
}

- (void)setTile:(NSInteger)index at:(CGPoint)position {
    _map[(NSInteger)position.y][(NSInteger)position.x] = [SKSpriteNode spriteNodeWithImageNamed:_tiles[index]];
}

+ (CGPoint)isometric:(CGPoint)cartesian {
    return CGPointMake(cartesian.x + cartesian.y, cartesian.y - cartesian.x/2.0);
}

+ (CGPoint)cartesian:(CGPoint)isometric {
    return CGPointMake((isometric.x - isometric.y)/1.5, isometric.y/1.5 + isometric.x/3.0);
}

@end
