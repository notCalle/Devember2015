//
//  IsoTile.m
//  Devember2015
//
//  Created by Calle Englund on 08/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTile.h"

@implementation IsoTile

-(instancetype)initWithTexture:(SKTexture *)texture {
    return [self initWithTexture:texture height:texture.size.height * 2.0 / texture.size.width];
}


-(instancetype)initWithTexture:(SKTexture *)texture height:(CGFloat)stepHeight {
    return [self initWithTexture:texture height:stepHeight cost:1.0];
}

-(instancetype)initWithTexture:(SKTexture *)texture height:(CGFloat)stepHeight cost:(CGFloat)stepCost {
    self = [super init];
    if (self) {
        _texture = texture;
        _stepHeight = stepHeight;
        _stepCost = stepCost;
        _noise = nil;
    }
    return self;
}

-(instancetype)initWithImageNamed:(NSString *)name {
    return [self initWithTexture:[SKTexture textureWithImageNamed:name]];
}

-(instancetype)initWithImageNamed:(NSString *)name height:(CGFloat)stepHeight {
    return [self initWithTexture:[SKTexture textureWithImageNamed:name] height:stepHeight];
}

-(instancetype)initWithImageNamed:(NSString *)name height:(CGFloat)stepHeight cost:(CGFloat)stepCost {
    return [self initWithTexture:[SKTexture textureWithImageNamed:name] height:stepHeight cost:stepCost];
}

// Must be overridden by subclasses
-(SKTexture *)clutterAt:(vector_int2)grid {
    return nil;
}

-(instancetype)initTile {
    return nil;
}

+(instancetype)tile {
    return nil;
}

@end
