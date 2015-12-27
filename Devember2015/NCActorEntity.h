//
//  NCActorEntity.h
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>

@class NCActorEntity;
@class GameScene;
@class IsoTileNode;

@protocol NCActorInteraction <NSObject>

@optional

-(void)didSpawnAt:(IsoTileNode *)tile;

-(void)didGetAttackedBy:(NCActorEntity *)aggressor;
-(void)didGetKilledBy:(NCActorEntity *)aggressor;
-(void)didKill:(NCActorEntity *)victim;

-(void)didLightTorch:(BOOL)isLit;
-(void)didReplaceTorch;

@end

@interface NCActorEntity : GKEntity <NCActorInteraction>

@property(readonly) NSString *name;
@property GameScene *scene;

-(instancetype)initWithName:(NSString *)name;

+(instancetype)playerEntityForScene:(GameScene *)scene;
+(instancetype)creepyEntityForScene:(GameScene *)scene;
+(instancetype)crawlyEntityForScene:(GameScene *)scene;

@end
