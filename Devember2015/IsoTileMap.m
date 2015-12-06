//
//  IsoTileMap.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTileMap.h"

@implementation IsoTileMap

-(instancetype)init {
    self = [super init];
    if (self) {
        _tiles = nil;
        _map = nil;
        self.lightingBitMask = 0x1;
    }
    return self;
}

- (instancetype)initWithTiles:(NSArray<NSString *> *)tiles mapSize:(CGSize)size {
    NSInteger row;
    
    self = [self init];
    if (self) {
        _tiles = tiles;
        _map = [NSMutableArray arrayWithCapacity:size.height];
        
        _width = (NSInteger)size.width;
        _height = (NSInteger)size.height;
        _position = CGPointMake(0, 0);
        _centerTile = CGPointMake(0, 0);
        _gridsize = 0.0;
        
        for (row = 0; row < _height; row++) {
            _map[row] = [NSMutableArray arrayWithCapacity:_width];
        }
    }
    return self;
}

- (SKSpriteNode *)tileAt:(CGPoint)grid {
    if (grid.x >= 0 &&
        grid.y >= 0 &&
        grid.x < _width &&
        grid.y < _height) {
        return _map[(NSInteger)grid.y][(NSInteger)grid.x];
    } else {
        return nil;
    }
}

-(void)addChild:(ITSpriteNode *)sprite toTileAt:(CGPoint)grid {
    ITSpriteNode *tile = [self tileAt:grid];
    if (tile) {
//        sprite.position = CGPointMake(tile.size.width / 2.0, tile.size.width / 4.0);
        [tile addChild:sprite];
    }
}

- (void)setTile:(NSInteger)index at:(CGPoint)grid {
    ITSpriteNode *sprite = [ITSpriteNode spriteNodeWithImageNamed:_tiles[index]];
    
    if (sprite.size.width > _gridsize)
        _gridsize = sprite.size.width;
    
    sprite.lightingBitMask = 0x1;
    [self addChild:sprite];
    
    _map[(NSInteger)grid.y][(NSInteger)grid.x] = sprite;
}

- (CGPoint)centerTile {
    return _centerTile;
}

- (void)setCenterTile:(CGPoint)centerTile {
    _centerTile = centerTile;
    [self repositionTiles];
}

- (void)positionSprite:(ITSpriteNode *)sprite at:(CGPoint)grid {
    CGPoint cartesian = CGPointMake((grid.x - _centerTile.x) * _gridsize, (_centerTile.y - grid.y) * _gridsize);
    CGPoint isometric = CGPointMake((cartesian.x + cartesian.y)/2.0, (cartesian.y - cartesian.x)/4.0);

    sprite.position = CGPointMake(isometric.x, isometric.y);
    sprite.anchorPoint = CGPointMake(0.5, sprite.size.width/sprite.size.height/4);
    sprite.zPosition = grid.x+grid.y;
}

- (void)repositionTiles {
    NSInteger x,y;
    
    for (y=0; y<_height; y++) {
        for (x=0; x<_width; x++) {
            ITSpriteNode *sprite = _map[y][x];
            if (y>0) {
                sprite.north = _map[y-1][x];
            }
            if (x>0) {
                sprite.west = _map[y][x-1];
            }
            [self positionSprite:sprite at:CGPointMake(x, y)];
        }
    }
}

- (CGPoint)gridAtLocation:(CGPoint)location {
    CGPoint isometric = CGPointMake((location.x - _position.x)/_gridsize, (_position.y - location.y)/_gridsize*2);
    CGPoint cartesian = CGPointMake(round(isometric.x + isometric.y + _centerTile.x),
                                    round(isometric.y - isometric.x + _centerTile.y));
    return cartesian;
}

@end
