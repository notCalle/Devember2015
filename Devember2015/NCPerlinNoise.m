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
    self = [super init];
    if (self) {
        _octaves = octaves;
        _persistance = persistance;
    }
    return self;
}

+(instancetype)octaves:(NSInteger)octaves {
    return [[NCPerlinNoise alloc] initOctaves:octaves];
}

+(instancetype)octaves:(NSInteger)octaves persistance:(CGFloat)persistance {
    return [[NCPerlinNoise alloc] initOctaves:octaves persistance:persistance];
}


-(CGFloat)perlinNoise2:(CGPoint)coord {
    CGFloat sum = 0.0;
    CGFloat amplitude = 1.0;
    CGFloat frequency = 1.0;
    int n;
    
    for (n=0; n<_octaves; n++) {
        sum += [NCPerlinNoise interpolatedNoise2:CGPointMake(coord.x * frequency, coord.y * frequency)] * amplitude;
        frequency *= 2;
        amplitude *= _persistance;
    }
    return sum;
}

+(CGFloat)noise:(int)x {
    int n = (x << 13) ^ x;
    return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0);
}

+(CGFloat)noise2:(vector_int2)coord {
    return [NCPerlinNoise noise:coord.x + coord.y*57];
}

+(CGFloat)smoothNoise2:(vector_int2)coord {
    CGFloat corners = ([NCPerlinNoise noise2:(vector_int2){coord.x-1, coord.y-1}] +
                       [NCPerlinNoise noise2:(vector_int2){coord.x+1, coord.y-1}] +
                       [NCPerlinNoise noise2:(vector_int2){coord.x+1, coord.y+1}] +
                       [NCPerlinNoise noise2:(vector_int2){coord.x-1, coord.y+1}]) / 16.0;
    CGFloat sides = ([NCPerlinNoise noise2:(vector_int2){coord.x-1, coord.y  }] +
                     [NCPerlinNoise noise2:(vector_int2){coord.x,   coord.y-1}] +
                     [NCPerlinNoise noise2:(vector_int2){coord.x+1, coord.y  }] +
                     [NCPerlinNoise noise2:(vector_int2){coord.x,   coord.y+1}]) / 8.0;
    CGFloat center = [NCPerlinNoise noise2:coord] / 4.0;
    return center + sides + corners;
}

+(CGFloat)interpolate:(CGFloat)v1 and:(CGFloat)v2 with:(CGFloat)fraction {
    CGFloat f = (1-cosf(fraction*3.1415927)) * 0.5;
    return v1*(1-f) + v2*f;
}

+(CGFloat)interpolatedNoise2:(CGPoint)coord {
    int intX = coord.x;
    int intY = coord.y;
    CGFloat fracX = coord.x - intX;
    CGFloat fracY = coord.y - intY;
    
    CGFloat x1y1 = [NCPerlinNoise smoothNoise2:(vector_int2){intX  ,intY  }];
    CGFloat x2y1 = [NCPerlinNoise smoothNoise2:(vector_int2){intX+1,intY  }];
    CGFloat x1y2 = [NCPerlinNoise smoothNoise2:(vector_int2){intX  ,intY+1}];
    CGFloat x2y2 = [NCPerlinNoise smoothNoise2:(vector_int2){intX+1,intY+1}];

    CGFloat x12y1 = [NCPerlinNoise interpolate:x1y1 and:x2y1 with:fracX];
    CGFloat x12y2 = [NCPerlinNoise interpolate:x1y2 and:x2y2 with:fracX];
    
    return [NCPerlinNoise interpolate:x12y1 and:x12y2 with:fracY];
}

@end
