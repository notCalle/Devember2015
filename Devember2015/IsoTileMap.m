//
//  IsoTileMap.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTileMap.h"
#import "IsoTile.h"
#import "SubsampledTile.h"
#import "IsoTileNode.h"

@implementation IsoTileMap

-(instancetype)init {
    self = [super init];
    if (self) {
        _tiles = nil;
        _map = nil;
        self.lightingBitMask = 0x1;
        _random = [[GKRandomSource alloc] init];
        _minimum_cost = CGFLOAT_MAX;
    }
    return self;
}

- (instancetype)initWithTiles:(NSArray<IsoTile *> *)tiles width:(NSInteger)width height:(NSInteger)height {
    NSInteger row;
    
    self = [self init];
    if (self) {
        _tiles = tiles;
        _map = [NSMutableArray arrayWithCapacity:height];
        
        _width = (NSInteger)width;
        _height = (NSInteger)height;
        _position = CGPointMake(0, 0);
        _centerTile = (vector_int2){(int)width/2,(int)height/2};
        _gridsize = 0.0;
        for (row = 0; row < _height; row++) {
            _map[row] = [NSMutableArray arrayWithCapacity:_width];
        }
    }
    return self;
}

- (IsoTileNode *)tileAt:(vector_int2)grid {
    if (grid.x >= 0 &&
        grid.y >= 0 &&
        grid.x < _width &&
        grid.y < _height) {
        return _map[grid.y][grid.x];
    } else {
        return nil;
    }
}

-(void)addChild:(IsoTileNode *)sprite toTileAt:(vector_int2)grid {
    IsoTileNode *tile = [self tileAt:grid];
    if (tile) {
        [tile addChild:sprite];
    }
}

- (void)setTile:(NSInteger)index at:(vector_int2)grid {
    IsoTileNode *sprite = [[IsoTileNode alloc] initWithTile:_tiles[index]];
    
    if (sprite.size.width > _gridsize)
        _gridsize = sprite.size.width;
    if (sprite.tile.stepCost < _minimum_cost)
        _minimum_cost = sprite.tile.stepCost;
    
    if (grid.y>0) {
        sprite.north = _map[grid.y-1][grid.x];
        if (grid.x<_width-1) {
            sprite.northEast = _map[grid.y-1][grid.x+1];
        }
    }
    if (grid.x>0) {
        sprite.west = _map[grid.y][grid.x-1];
        if (grid.y>0) {
            sprite.northWest = _map[grid.y-1][grid.x-1];
        }
    }
    
    sprite.lightingBitMask = 0x1;
    [self addChild:sprite];
    
    _map[grid.y][grid.x] = sprite;
    [self positionTile:sprite at:grid];
}

- (void)setSSTile:(uint16_t)sub at:(vector_int2)grid {
    SubsampledTile *tile = [SubsampledTile tileWith:sub];
    IsoTileNode *sprite = [[IsoTileNode alloc] initWithTile:tile];
    
    if (sprite.size.width > _gridsize)
        _gridsize = sprite.size.width;
    if (sprite.tile.stepCost < _minimum_cost)
        _minimum_cost = sprite.tile.stepCost;
    
    if (grid.y>0) {
        sprite.north = _map[grid.y-1][grid.x];
        if (grid.x<_width-1) {
            sprite.northEast = _map[grid.y-1][grid.x+1];
        }
    }
    if (grid.x>0) {
        sprite.west = _map[grid.y][grid.x-1];
        if (grid.y>0) {
            sprite.northWest = _map[grid.y-1][grid.x-1];
        }
    }
    
    sprite.lightingBitMask = 0x1;
    [self addChild:sprite];
    
    _map[grid.y][grid.x] = sprite;
    [self positionTile:sprite at:grid];
}

- (vector_int2)centerTile {
    return _centerTile;
}

- (void)setCenterTile:(vector_int2)centerTile {
    _centerTile = centerTile;
    [self repositionTiles];
}

- (void)positionTile:(IsoTileNode *)sprite at:(vector_int2)grid {
    CGPoint cartesian = CGPointMake((grid.x - _centerTile.x) * _gridsize, (_centerTile.y - grid.y) * _gridsize);
    CGPoint isometric = CGPointMake((cartesian.x + cartesian.y)/2.0, (cartesian.y - cartesian.x)/4.0);

    sprite.gridPosition = grid;
    sprite.position = CGPointMake(isometric.x, isometric.y);
    sprite.anchorPoint = CGPointMake(0.5, sprite.size.width/sprite.size.height/4);
}

- (void)repositionTiles {
    int x,y;

    for (y=0; y<_height; y++) {
        for (x=0; x<_width; x++) {
            IsoTileNode *sprite = _map[y][x];
            [self positionTile:sprite at:(vector_int2){x,y}];
        }
    }
}

- (vector_int2)gridAtLocation:(CGPoint)location {
    CGPoint local = [self convertPoint:location fromNode:self.parent];
    CGPoint isometric = CGPointMake(local.x/_gridsize, -local.y/_gridsize*2);
    vector_int2 cartesian = (vector_int2){
        round(isometric.x + isometric.y + _centerTile.x),
        round(isometric.y - isometric.x + _centerTile.y)};
    return cartesian;
}

-(CGFloat)bestPathCostFrom:(IsoTileNode *)here to:(IsoTileNode *)there {
    vector_int2 hereGrid = here.gridPosition;
    vector_int2 thereGrid = there.gridPosition;
    int xDelta = abs(hereGrid.x - thereGrid.x);
    int yDelta = abs(hereGrid.y - thereGrid.y);
    
    // Pythagoras is approximated by max(dx,dy)+min(dx,dy)/2; diagonal move = 1.5
    return _minimum_cost * ((xDelta>yDelta) ? (xDelta + yDelta/2.0) : (xDelta/2.0 + yDelta));
}

-(void)randomizeMap {
    NSRange range = {
        .location = 0,
        .length = _tiles.count
    };
    [self randomizeMapUsingTiles:range];
}

-(void)randomizeMapUsingTiles:(NSRange)range {
    int x,y;

    NCPerlinNoise *noise = [NCPerlinNoise octaves:7];
    
    for (y=0; y<_height; y++) {
        for (x=0; x<_width; x++) {
            NSInteger tile = range.location +
                              (range.length - 1) *
                              ([noise perlinNoise2:CGPointMake(x/100.0, y/100.0)] + 1.0)/2.0;
            [self setTile:tile at:(vector_int2){x, y}];
        }
    }
}

-(void)randomizeMapUsingSubsample:(NSRange)range {
    int x,y;
    
    NCPerlinNoise *noise = [NCPerlinNoise octaves:7];
    
    for (y=0; y<_height; y++) {
        for (x=0; x<_width; x++) {
            NSInteger ss1 = range.location +
            (range.length - 1) *
            ([noise perlinNoise2:CGPointMake(x/100.0, y/100.0)] + 1.0)/2.0;
            NSInteger ss2 = range.location +
            (range.length - 1) *
            ([noise perlinNoise2:CGPointMake(x/100.0, (y+1)/100.0)] + 1.0)/2.0;
            NSInteger ss3 = range.location +
            (range.length - 1) *
            ([noise perlinNoise2:CGPointMake((x+1)/100.0, y/100.0)] + 1.0)/2.0;
            NSInteger ss4 = range.location +
            (range.length - 1) *
            ([noise perlinNoise2:CGPointMake((x+1)/100.0, (y+1)/100.0)] + 1.0)/2.0;

            uint16_t subsample = ss1<<12 | ss2<<8 | ss3<<4 | ss4;
            [self setSSTile:subsample at:(vector_int2){x, y}];
        }
    }
}

@end
