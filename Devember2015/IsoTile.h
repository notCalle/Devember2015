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

-(instancetype)initWithTexture:(SKTexture *)texture;
-(instancetype)initWithTexture:(SKTexture *)texture height:(CGFloat)stepHeight;
-(instancetype)initWithTexture:(SKTexture *)texture height:(CGFloat)stepHeight cost:(CGFloat)stepCost;
-(instancetype)initWithImageNamed:(NSString *)name;
-(instancetype)initWithImageNamed:(NSString *)name height:(CGFloat)stepHeight;
-(instancetype)initWithImageNamed:(NSString *)name height:(CGFloat)stepHeight cost:(CGFloat)stepCost;

+(instancetype)tile;

@end
