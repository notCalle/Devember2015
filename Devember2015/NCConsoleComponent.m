//
//  NCConsoleComponent.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-27.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCConsoleComponent.h"
#import "GameScene.h"
#import "NCConsoleNode.h"
#import "IsoTileNode.h"

@implementation NCConsoleComponent

-(instancetype)init {
    self = [super init];
    if (self) {
        _priority = 20.0;
    }
    return self;
}

-(instancetype)initWithConsole:(NCConsoleNode *)console {
    self = [self init];
    if (self) {
        _console = console;
    }
    return self;
}

#pragma mark - NCActorInteraction Protocol

-(void)didGetAttackedBy:(NCActorEntity *)aggressor for:(CGFloat)damage {
    NCActorEntity *entity = (NCActorEntity *)self.entity;

    [_console addText:[NSString stringWithFormat:@"%@ was hit by %@ for %.1f",
                       entity.name, aggressor.name, damage]];

}

-(void)didAvoidAttackBy:(NCActorEntity *)aggressor {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    [_console addText:[NSString stringWithFormat:@"%@ ducks %@'s feeble attempt",
                       entity.name, aggressor.name]];
}

-(void)didGetKilledBy:(NCActorEntity *)aggressor {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    [_console addText:[NSString stringWithFormat:@"%@ was killed by %@",
                       entity.name, aggressor.name]];
}

-(void)didLightTorch:(BOOL)isLit {
    NCActorEntity *entity = (NCActorEntity *)self.entity;

    if (isLit) {
        [_console addText:[NSString stringWithFormat:@"%@ lit their torch",
                           entity.name]];
    } else {
        [_console addText:[NSString stringWithFormat:@"%@ put out their torch",
                           entity.name]];
    }
}

-(void)didReplaceTorch {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    [_console addText:[NSString stringWithFormat:@"%@ replaced their torch",
                       entity.name]];
}

-(void)willAttack:(NCActorEntity *)victim {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    [_console addText:[NSString stringWithFormat:@"%@ takes a swing at %@",
                       entity.name, victim.name]];
}

-(void)didSpawnAt:(IsoTileNode *)tile {
    NCActorEntity *entity = (NCActorEntity *)self.entity;

    [_console addText:[NSString stringWithFormat:@"%@ spawned at %d,%d",
                       entity.name, tile.gridPosition.x, tile.gridPosition.y]];
}

@end
