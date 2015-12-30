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
@class NCRandomResolver;

@protocol NCActorInteraction <NSObject>

@optional

-(void)didSpawnAt:(IsoTileNode *)tile;
-(void)willMoveTo:(IsoTileNode *)tile;
-(void)willMoveTo:(IsoTileNode *)tile maxSteps:(NSInteger)steps;
-(void)willMove:(NCMovementDirection)direction;

-(void)willAttack:(NCActorEntity *)victim;
-(void)didGetAttackedBy:(NCActorEntity *)aggressor for:(CGFloat)damage;
-(void)didAvoidAttackBy:(NCActorEntity *)aggressor;
-(void)didGetKilledBy:(NCActorEntity *)aggressor;
-(void)didKill:(NCActorEntity *)victim;

-(void)didGainXP:(NSInteger)experienceDelta;
-(void)didGainLevel:(NSInteger)levelDelta;
-(void)willLightTorch;
-(void)didLightTorch:(BOOL)isLit;
-(void)didReplaceTorch;

@end

@interface NCActorEntity : GKEntity <NCActorInteraction>
@property(readonly) NSString *name;
@property GameScene *scene;
@property(readonly) NCBodyComponent *body;
@property(readonly) NCRandomResolver *resolve;

-(instancetype)initWithName:(NSString *)name;

@end
