//
//  NCCrawlyEntity.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-27.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCCrawlyEntity.h"
#import "NCSpriteNode.h"
#import "NCBodyComponent.h"
#import "NCMobBrainComponent.h"
#import "NCConsoleComponent.h"
#import "GameScene.h"

@implementation NCCrawlyEntity

+(instancetype)entityForScene:(GameScene *)scene {
    NCCrawlyEntity *this = [[NCCrawlyEntity alloc] initWithName:@"Crawly"];
    if (this) {
        this.scene = scene;
        
        NCConsoleComponent *console = [[NCConsoleComponent alloc] initWithConsole:scene.console];
        [this addComponent:console];

        NCSpriteNode *sprite = [[NCSpriteNode alloc] initWithEntity:this];
        sprite.texture = [SKTexture textureWithImageNamed:@"Clutter/Crawly"];
        
        NCBodyComponent *body = [[NCBodyComponent alloc] initWithSprite:sprite];
        body.stepHeight = 1.0;
        body.stepSpeed = 0.3;
        body.health = 3.0;
        [this addComponent:body];
        
        NCMobBrainComponent *brain = [NCMobBrainComponent new];
        brain.cowardice = 2.0;
        brain.curiosity = 10.0;
        brain.aggressiveness = 20.0;
        [this addComponent:brain];
    }
    return this;
}

@end
