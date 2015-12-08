//
//  ITSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 06/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTileNode.h"

@implementation IsoTileNode

-(instancetype)init {
    self = [super init];
    if (self) {
        _north = nil;
        _south = nil;
        _west = nil;
        _east = nil;
        _tile = nil;
    }
    return self;
}

-(instancetype)initWithTile:(IsoTile *)tile {
    self = [self init];
    if (self) {
        _tile = tile;
        self.texture = tile.texture;
        self.size = tile.texture.size;
    }
    return self;
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

-(void)setSouth:(IsoTileNode *)south {
    if (_south != south) {
        if (_south) {
            _south.north = nil;
        }
        _south = south;
        south.north = self;
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

-(void)setEast:(IsoTileNode *)east {
    if (_east != east) {
        if (_east) {
            _east.west = nil;
        }
        _east = east;
        east.west = self;
    }
}

@end
