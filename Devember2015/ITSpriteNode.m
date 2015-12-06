//
//  ITSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 06/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "ITSpriteNode.h"

@implementation ITSpriteNode

-(instancetype)init {
    self = [super init];
    if (self) {
        _north = nil;
        _south = nil;
        _west = nil;
        _east = nil;
    }
    return self;
}

-(void)setNorth:(ITSpriteNode *)north {
    if (_north != north) {
        if (_north) {
            _north.south = nil;
        }
        _north = north;
        north.south = self;
    }
}

-(void)setSouth:(ITSpriteNode *)south {
    if (_south != south) {
        if (_south) {
            _south.north = nil;
        }
        _south = south;
        south.north = self;
    }
}

-(void)setWest:(ITSpriteNode *)west {
    if (_west != west) {
        if (_west) {
            _west.east = nil;
        }
        _west = west;
        west.east = self;
    }
}

-(void)setEast:(ITSpriteNode *)east {
    if (_east != east) {
        if (_east) {
            _east.west = nil;
        }
        _east = east;
        east.west = self;
    }
}

@end
