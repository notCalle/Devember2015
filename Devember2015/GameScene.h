//
//  GameScene.h
//  Devember2015
//

//  Copyright (c) 2015 Calle Englund. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class IsoTileMap;
@class NCPlayerBrainComponent;
@class NCActorEntity;
@class NCConsoleNode;

@interface GameScene : SKScene

@property IsoTileMap *tileMap;
@property NCActorEntity *player;
@property NSMutableSet<NCActorEntity *> *actors;
@property(readonly) NCConsoleNode *console;
@property(readonly) CGFloat daylight;
@property CGFloat torchlight;
@property(readonly) CGFloat light;
@property(readonly) NSColor *ambientColor;
@property(readonly) NSTimeInterval lastTime;

@end
