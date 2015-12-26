//
//  NCActorEntity.m
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCActorEntity.h"
#import "NCSpriteNode.h"
#import "NCBodyComponent.h"
#import "NCTorchComponent.h"
#import "NCPlayerBrainComponent.h"

@implementation NCActorEntity

-(instancetype)init {
    self = [super init];
    if (self) {
        _name = self.className;
    }
    return self;
}

-(instancetype)initWithName:(NSString *)name {
    self = [self init];
    if (self) {
        _name = name;
    }
    return self;
}

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    for (GKComponent *component in self.components) {
        [component updateWithDeltaTime:seconds];
    }
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = anInvocation.selector;
    
    for (GKComponent *component in self.components) {
        if ([component respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:component];
        }
    }
    [super forwardInvocation:anInvocation];
}

#pragma mark - entity kinds

+(instancetype)playerEntityForScene:(GameScene *)scene {
    NCActorEntity *this = [[NCActorEntity alloc] initWithName:@"player"];
    if (this) {
        this.scene = scene;
        
        NCSpriteNode *sprite = [[NCSpriteNode alloc] initWithEntity:this];
        sprite.texture = [SKTexture textureWithImageNamed:@"Clutter/Player"];
        sprite.anchorPoint = CGPointMake(0.5, 0);
        
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
