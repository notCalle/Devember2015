//
//  IsoTileScene.m
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTileScene.h"

@implementation IsoTileScene

- (instancetype)initWithTileMap:(TileMap *)tileMap {
    self = [self init];
    if (self) {
        _tileMap = tileMap;
    }
    return self;
}

+ (CGPoint)isometric:(CGPoint)cartesian {
    return CGPointMake(cartesian.x + cartesian.y, cartesian.y - cartesian.x/2.0);
}

+ (CGPoint)cartesian:(CGPoint)isometric {
    return CGPointMake((isometric.x - isometric.y)/1.5, isometric.y/1.5 + isometric.x/3.0);
}

@end
