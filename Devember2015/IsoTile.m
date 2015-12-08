//
//  IsoTile.m
//  Devember2015
//
//  Created by Calle Englund on 08/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "IsoTile.h"

@implementation IsoTile

+(instancetype)tileWithTexture:(SKTexture *)texture {
    return [IsoTile tileWithTexture:texture andStep:texture.size.height * 2.0 / texture.size.width];
}

+(instancetype)tileWithTexture:(SKTexture *)texture andStep:(CGFloat)stepHeight {
    IsoTile *object = [[IsoTile alloc] init];
    if (object) {
        object.texture = texture;
        object.stepHeight = stepHeight;
    }
    return object;
}

+(instancetype)tileWithImageNamed:(NSString *)name {
    return [IsoTile tileWithTexture:[SKTexture textureWithImageNamed:name]];
}

+(instancetype)tileWithImageNamed:(NSString *)name andStep:(CGFloat)stepHeight {
    return [IsoTile tileWithTexture:[SKTexture textureWithImageNamed:name] andStep:stepHeight];
}

@end
