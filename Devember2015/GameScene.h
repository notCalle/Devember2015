//
//  GameScene.h
//  Devember2015
//

//  Copyright (c) 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Tiles.h"
#import "IsoTileMap.h"
#import "PlayerSpriteNode.h"
#import "NCPathFinder.h"
#import "NCConsoleNode.h"

@interface GameScene : SKScene

@property IsoTileMap *tileMap;
@property PlayerSpriteNode *player;
@property NSMutableSet<ActorSpriteNode *> *actors;
@property NCConsoleNode *console;

@end
