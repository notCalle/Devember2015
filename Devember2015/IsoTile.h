//
//  IsoTile.h
//  Devember2015
//
//  Created by Calle Englund on 08/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface IsoTile : NSObject

@property SKTexture *texture;
@property CGFloat stepHeight;

+(instancetype)tileWithTexture:(SKTexture *)texture;
+(instancetype)tileWithTexture:(SKTexture *)texture andStep:(CGFloat)stepHeight;
+(instancetype)tileWithImageNamed:(NSString *)name;
+(instancetype)tileWithImageNamed:(NSString *)name andStep:(CGFloat)stepHeight;

@end
