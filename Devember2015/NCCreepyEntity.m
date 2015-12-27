//
//  NCCreepyEntity.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-27.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCCreepyEntity.h"
#import "NCSpriteNode.h"
#import "NCBodyComponent.h"
#import "NCMobBrainComponent.h"
#import "NCConsoleComponent.h"
#import "GameScene.h"

@implementation NCCreepyEntity

+(instancetype)entityForScene:(GameScene *)scene {
    NCCreepyEntity *this = [[NCCreepyEntity alloc] initWithName:@"Creepy"];
    if (this) {
        this.scene = scene;
        
        NCSpriteNode *sprite = [[NCSpriteNode alloc] initWithEntity:this];
        sprite.texture = [SKTexture textureWithImageNamed:@"Clutter/Creepy"];
        
        NCBodyComponent *body = [[NCBodyComponent alloc] initWithSprite:sprite];
        body.stepHeight = 0.5;
        body.stepSpeed = 0.5;
        body.health = 2.0;
        [this addComponent:body];
        
        NCMobBrainComponent *brain = [NCMobBrainComponent new];
        brain.cowardice = 5.0;
        brain.curiosity = 10.0;
        brain.aggressiveness = 3.0;
        [this addComponent:brain];
    }
    return this;
}

@end
