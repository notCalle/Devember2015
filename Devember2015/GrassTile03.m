//
//  GrassTile03.m
//  Devember2015
//
//  Created by Calle Englund on 18/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "GrassTile03.h"
#import "NCPerlinNoise.h"
#import "ClutterSpriteNode.h"

@implementation GrassTile03

-(instancetype)initTile {
    self = [self initWithImageNamed:@"Terrain/03-Grass" height:1.5 cost:1.0];
    if (self) {
        _noise = [NCPerlinNoise octaves:3 persistance:1.0 seed:0xdeadbeef];
        _clutter = @[
                     [SKTexture textureWithImageNamed:@"Clutter/Tree1"],
                     [SKTexture textureWithImageNamed:@"Clutter/Tree2"],
                     ];
    }
    return self;
}

+(instancetype)tile {
    return [[GrassTile03 alloc] initTile];
}

-(SKSpriteNode *)clutterAt:(vector_int2)grid {
    int rnd = (int)fabs((7 * [_noise perlinNoise2:CGPointMake(grid.x/3.0, grid.y/3.0)]));
    if (rnd < 2) {
        ClutterSpriteNode *clutter = [ClutterSpriteNode spriteNodeWithTexture:_clutter[rnd]];
        clutter.lightingBitMask = 0x1;
        clutter.anchorPoint = CGPointMake(0.5, 0.0);
        return clutter;
    }
    return nil;
}

@end
