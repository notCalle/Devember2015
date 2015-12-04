//
//  GameScene.h
//  Devember2015
//

//  Copyright (c) 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "IsoTileMap.h"

@interface GameScene : SKScene

@property IsoTileMap *tileMap;
@property SKSpriteNode *player;

@end
