//
//  NCPerlinNoise.h
//  Devember2015
//
//  Created by Calle Englund on 16/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
@interface NCPerlinNoise : NSObject {
    CGFloat _persistance;
    NSInteger _octaves;
}

-(instancetype)initOctaves:(NSInteger)octaves;
-(instancetype)initOctaves:(NSInteger)octaves persistance:(CGFloat)persistance;
+(instancetype)octaves:(NSInteger)octaves;
+(instancetype)octaves:(NSInteger)octaves persistance:(CGFloat)persistance;

-(CGFloat)perlinNoise:(CGFloat)x;
-(CGFloat)perlinNoise2:(CGPoint)coord;

+(CGFloat)interpolate:(CGFloat)v1 and:(CGFloat)v2 with:(CGFloat)fraction;
+(CGFloat)noise:(int)x;
+(CGFloat)noise2:(vector_int2)coord;
+(CGFloat)smoothNoise:(int)x;
+(CGFloat)smoothNoise2:(vector_int2)coord;
+(CGFloat)interpolatedNoise:(CGFloat)x;
+(CGFloat)interpolatedNoise2:(CGPoint)coord;

@end
