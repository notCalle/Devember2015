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
    return [IsoTile tileWithTexture:texture height:texture.size.height * 2.0 / texture.size.width];
}


+(instancetype)tileWithTexture:(SKTexture *)texture height:(CGFloat)stepHeight {
    return [IsoTile tileWithTexture:texture height:stepHeight cost:1.0];
}

+(instancetype)tileWithTexture:(SKTexture *)texture height:(CGFloat)stepHeight cost:(CGFloat)stepCost {
    IsoTile *object = [[IsoTile alloc] init];
    if (object) {
        object.texture = texture;
        object.stepHeight = stepHeight;
        object.stepCost = stepCost;
    }
    return object;
}

+(instancetype)tileWithImageNamed:(NSString *)name {
    return [IsoTile tileWithTexture:[SKTexture textureWithImageNamed:name]];
}

+(instancetype)tileWithImageNamed:(NSString *)name height:(CGFloat)stepHeight {
    return [IsoTile tileWithTexture:[SKTexture textureWithImageNamed:name] height:stepHeight];
}

+(instancetype)tileWithImageNamed:(NSString *)name height:(CGFloat)stepHeight cost:(CGFloat)stepCost {
    return [IsoTile tileWithTexture:[SKTexture textureWithImageNamed:name] height:stepHeight cost:stepCost];
}

@end
