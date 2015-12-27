//
//  NCSpriteComponent.h
//  Devember2015
//
//  Created by Calle Englund on 25/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import <SpriteKit/SpriteKit.h>
#import "NCDirection.h"
#import "NCActorEntity.h"

@class NCSpriteNode;
@class IsoTileNode;

@interface NCBodyComponent : GKComponent <NCActorInteraction>

@property NCSpriteNode *sprite;
@property NSMutableArray<SKAction *> *movement;

@property CGFloat direction;
@property CGFloat stepHeight;
@property CGFloat stepSpeed;
@property CGFloat health;

-(instancetype)initWithSprite:(NCSpriteNode *)sprite;

//-(void)step:(NCMovementDirection)direction;
-(void)stepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

-(BOOL)canStepTo:(IsoTileNode *)target;
-(BOOL)canStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;
-(CGFloat)costOfStepTo:(IsoTileNode *)target;
-(CGFloat)costOfStepTo:(IsoTileNode *)target from:(IsoTileNode *)here;

@end
