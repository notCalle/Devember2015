//
//  NCPlayerBrainComponent.m
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCPlayerBrainComponent.h"
#import "NCBodyComponent.h"
#import "NCTorchComponent.h"
#import "NCActorEntity.h"
#import "NCSpriteNode.h"
#import "GameScene.h"
#import "IsoTileMap.h"

@implementation NCPlayerBrainComponent

-(void)willLightTorch {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    NCTorchComponent *torch = (NCTorchComponent *)[entity componentForClass:[NCTorchComponent class]];
    if (torch) {
        if (torch.isLit) {
            [entity didLightTorch:NO];
        } else {
            if (torch.burnOut > 0.5) {
                [entity didReplaceTorch];
            }
            [entity didLightTorch:YES];
        }
    }
}

-(void)willAttack:(NCActorEntity *)victim {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    [victim didGetAttackedBy:entity for:entity.body.healthGrade];
}

-(void)didGetKilledBy:(NCActorEntity *)aggressor {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    
    entity.scene.player = nil;
    [entity.scene.tileMap runAction:[SKAction fadeOutWithDuration:10.0]];
}

@end
