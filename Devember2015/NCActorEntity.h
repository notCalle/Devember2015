//
//  NCActorEntity.h
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import "NCDirection.h"

@class NCActorEntity;
@class GameScene;
@class IsoTileNode;
@class NCBodyComponent;

@protocol NCActorInteraction <NSObject>

@optional

-(void)didSpawnAt:(IsoTileNode *)tile;
-(void)willMoveTo:(IsoTileNode *)tile;
-(void)willMoveTo:(IsoTileNode *)tile maxSteps:(NSInteger)steps;
-(void)willMove:(NCMovementDirection)direction;

-(void)willAttack:(NCActorEntity *)victim;
-(void)didGetAttackedBy:(NCActorEntity *)aggressor for:(CGFloat)damage;
-(void)didGetKilledBy:(NCActorEntity *)aggressor;
-(void)didKill:(NCActorEntity *)victim;

-(void)willLightTorch;
-(void)didLightTorch:(BOOL)isLit;
-(void)didReplaceTorch;

@end

@interface NCActorEntity : GKEntity <NCActorInteraction>
@property(readonly) NSString *name;
@property GameScene *scene;
@property(readonly) NCBodyComponent *body;

-(instancetype)initWithName:(NSString *)name;

@end
