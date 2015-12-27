//
//  NCPlayerEntity.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-27.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCPlayerEntity.h"
#import "NCSpriteNode.h"
#import "NCBodyComponent.h"
#import "NCTorchComponent.h"
#import "NCPlayerBrainComponent.h"
#import "NCConsoleComponent.h"
#import "GameScene.h"

@implementation NCPlayerEntity

+(instancetype)entityForScene:(GameScene *)scene {
    NCPlayerEntity *this = [[NCPlayerEntity alloc] initWithName:@"Player"];
    if (this) {
        this.scene = scene;

        NCConsoleComponent *console = [[NCConsoleComponent alloc] initWithConsole:scene.console];
        [this addComponent:console];
        
        NCSpriteNode *sprite = [[NCSpriteNode alloc] initWithEntity:this];
        sprite.texture = [SKTexture textureWithImageNamed:@"Clutter/Player"];
        
        NCBodyComponent *body = [[NCBodyComponent alloc] initWithSprite:sprite];
        body.stepHeight = 0.5;
        body.stepSpeed = 1.0;
        body.health = 10.0;
        [this addComponent:body];
        
        NCTorchComponent *torch = [NCTorchComponent new];
        [sprite addChild:torch.light];
        [this addComponent:torch];
        
        NCPlayerBrainComponent *brain = [NCPlayerBrainComponent new];
        [this addComponent:brain];
    }
    return this;
}

@end
