//
//  ITSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 06/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTileNode.h"
#import "GameScene.h"
#import "ClutterSpriteNode.h"

@implementation IsoTileNode

-(instancetype)init {
    self = [super init];
    if (self) {
        _north = nil;
        _south = nil;
        _west = nil;
        _east = nil;
        _tile = nil;
        _stepHeight = 0.0;
        _stepCost = 0.0;
    }
    return self;
}

-(instancetype)initWithTile:(IsoTile *)tile {
    self = [self init];
    if (self) {
        self.tile = tile;
    }
    return self;
}

-(NSArray<IsoTileNode *> *)neighbors {
    NSMutableArray *array = [NSMutableArray array];
    if (_east)
        [array addObject:_east];
    if (_northEast)
        [array addObject:_northEast];
    if (_north)
        [array addObject:_north];
    if (_northWest)
        [array addObject:_northWest];
    if (_west)
        [array addObject:_west];
    if (_southWest)
        [array addObject:_southWest];
    if (_south)
        [array addObject:_south];
    if (_southEast)
        [array addObject:_southEast];
    return array;
}

-(void)setTile:(IsoTile *)tile {
    _tile = tile;
    _stepCost = tile.stepCost;
    _stepHeight = tile.stepHeight;
    self.texture = tile.texture;
    self.size = tile.texture.size;
}

-(void)setEast:(IsoTileNode *)east {
    if (_east != east) {
        if (_east) {
            _east.west = nil;
        }
        _east = east;
        east.west = self;
    }
}

-(void)setNorthEast:(IsoTileNode *)northEast {
    if (_northEast != northEast) {
        if (_northEast) {
            _northEast.southWest = nil;
        }
        _northEast = northEast;
        northEast.southWest = self;
    }
}

-(void)setNorth:(IsoTileNode *)north {
    if (_north != north) {
        if (_north) {
            _north.south = nil;
        }
        _north = north;
        north.south = self;
    }
}

-(void)setNorthWest:(IsoTileNode *)northWest {
    if (_northWest != northWest) {
        if (_northWest) {
            _northWest.southEast = nil;
        }
        _northWest = northWest;
        northWest.southEast = self;
    }
}

-(void)setWest:(IsoTileNode *)west {
    if (_west != west) {
        if (_west) {
            _west.east = nil;
        }
        _west = west;
        west.east = self;
    }
}

-(void)setSouthWest:(IsoTileNode *)southWest {
    if (_southWest != southWest) {
        if (_southWest) {
            _southWest.northEast = nil;
        }
        _southWest = southWest;
        southWest.northEast = self;
    }
}

-(void)setSouth:(IsoTileNode *)south {
    if (_south != south) {
        if (_south) {
            _south.north = nil;
        }
        _south = south;
        south.north = self;
    }
}

-(void)setSouthEast:(IsoTileNode *)southEast {
    if (_southEast != southEast) {
        if (_southEast) {
            _southEast.northWest = nil;
        }
        _southEast = southEast;
        southEast.northWest = self;
    }
}

-(void)setGridPosition:(vector_int2)grid {
    _gridPosition = grid;
    self.zPosition = grid.x + grid.y;
    ClutterSpriteNode *clutter = (ClutterSpriteNode *)[_tile clutterAt:grid];
    if (clutter) {
        _stepCost *= 2;
        [clutter reParent:self];
    }
}


// NCGraphNode protocol

-(CGFloat)priority {
    return self.estimatedGoalCost;
}

@synthesize estimatedGoalCost;
@synthesize bestPathCost;
@synthesize cameFrom;
@synthesize visited;

@end
