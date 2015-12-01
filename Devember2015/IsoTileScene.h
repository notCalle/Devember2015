//
//  IsoTileScene.h
//  Devember2015
//
//  Created by Calle Englund on 01/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TileMap.h"

@interface IsoTileScene : SKScene
@property TileMap *tileMap;

- (instancetype)initWithTileMap:(TileMap *)tileMap;

+ (CGPoint)isometric:(CGPoint)cartesian;
+ (CGPoint)cartesian:(CGPoint)isometric;

@end
