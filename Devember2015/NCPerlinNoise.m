//
//  NCPerlinNoise.m
//  Devember2015
//
//  Created by Calle Englund on 16/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCPerlinNoise.h"

@implementation NCPerlinNoise

-(instancetype)initOctaves:(NSInteger)octaves {
    return [self initOctaves:octaves persistance:1.0];
}

-(instancetype)initOctaves:(NSInteger)octaves persistance:(CGFloat)persistance {
    return [self initOctaves:octaves persistance:persistance seed:0];
}

-(instancetype)initOctaves:(NSInteger)octaves persistance:(CGFloat)persistance seed:(NSInteger)seed {
    self = [super init];
    if (self) {
        _octaves = octaves;
        _persistance = persistance;
        _seed = seed;
    }
    return self;
}

+(instancetype)octaves:(NSInteger)octaves {
    return [[NCPerlinNoise alloc] initOctaves:octaves];
}

+(instancetype)octaves:(NSInteger)octaves persistance:(CGFloat)persistance {
    return [[NCPerlinNoise alloc] initOctaves:octaves persistance:persistance];
}

+(instancetype)octaves:(NSInteger)octaves persistance:(CGFloat)persistance seed:(NSInteger)seed {
    return [[NCPerlinNoise alloc] initOctaves:octaves persistance:persistance seed:seed];
}

-(CGFloat)perlinNoise2:(CGPoint)coord {
    CGFloat sum = 0.0;
    CGFloat amplitude = 1.0;
    CGFloat frequency = 1.0;
    int n;
    
    for (n=0; n<_octaves; n++) {
        sum += [self interpolatedNoise2:CGPointMake(coord.x * frequency, coord.y * frequency)] * amplitude;
        frequency *= 2;
        amplitude *= _persistance;
    }
    if (sum > 1.0)
        return 1.0;
    else if (sum < -1.0)
        return -1.0;
    else
        return sum;
}

-(CGFloat)noise:(int)x {
    NSInteger n = (x << 13) ^ x ^ _seed;
    return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0);
}

-(CGFloat)noise2:(vector_int2)coord {
    return [self noise:coord.x + coord.y*57];
}

-(CGFloat)smoothNoise2:(vector_int2)coord {
    CGFloat corners = ([self noise2:(vector_int2){coord.x-1, coord.y-1}] +
                       [self noise2:(vector_int2){coord.x+1, coord.y-1}] +
                       [self noise2:(vector_int2){coord.x+1, coord.y+1}] +
                       [self noise2:(vector_int2){coord.x-1, coord.y+1}]) / 16.0;
    CGFloat sides = ([self noise2:(vector_int2){coord.x-1, coord.y  }] +
                     [self noise2:(vector_int2){coord.x,   coord.y-1}] +
                     [self noise2:(vector_int2){coord.x+1, coord.y  }] +
                     [self noise2:(vector_int2){coord.x,   coord.y+1}]) / 8.0;
    CGFloat center = [self noise2:coord] / 4.0;
    return center + sides + corners;
}

-(CGFloat)interpolate:(CGFloat)v1 and:(CGFloat)v2 with:(CGFloat)fraction {
    CGFloat f = (1-cos(fraction*3.1415927)) * 0.5;
    return v1*(1-f) + v2*f;
}

-(CGFloat)interpolatedNoise2:(CGPoint)coord {
    int intX = coord.x;
    int intY = coord.y;
    CGFloat fracX = coord.x - intX;
    CGFloat fracY = coord.y - intY;
    
    CGFloat x1y1 = [self smoothNoise2:(vector_int2){intX  ,intY  }];
    CGFloat x2y1 = [self smoothNoise2:(vector_int2){intX+1,intY  }];
    CGFloat x1y2 = [self smoothNoise2:(vector_int2){intX  ,intY+1}];
    CGFloat x2y2 = [self smoothNoise2:(vector_int2){intX+1,intY+1}];

    CGFloat x12y1 = [self interpolate:x1y1 and:x2y1 with:fracX];
    CGFloat x12y2 = [self interpolate:x1y2 and:x2y2 with:fracX];
    
    return [self interpolate:x12y1 and:x12y2 with:fracY];
}

@end
