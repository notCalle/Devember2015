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
@property CGFloat stepCost;

+(instancetype)tileWithTexture:(SKTexture *)texture;
+(instancetype)tileWithTexture:(SKTexture *)texture height:(CGFloat)stepHeight;
+(instancetype)tileWithTexture:(SKTexture *)texture height:(CGFloat)stepHeight cost:(CGFloat)stepCost;
+(instancetype)tileWithImageNamed:(NSString *)name;
+(instancetype)tileWithImageNamed:(NSString *)name height:(CGFloat)stepHeight;
+(instancetype)tileWithImageNamed:(NSString *)name height:(CGFloat)stepHeight cost:(CGFloat)stepCost;

@end
