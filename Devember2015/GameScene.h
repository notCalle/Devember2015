//
//  GameScene.h
//  Devember2015
//

//  Copyright (c) 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "IsoTile.h"
#import "IsoTileMap.h"
#import "PlayerSpriteNode.h"
#import "PathFinder.h"

@interface GameScene : SKScene

@property IsoTileMap *tileMap;
@property PlayerSpriteNode *player;

@end
