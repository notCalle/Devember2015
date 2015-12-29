//
//  NCTorchComponent.m
//  Devember2015
//
//  Created by Calle Englund on 26/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "NCTorchComponent.h"
#import "NCBodyComponent.h"
#import "NCSpriteNode.h"
#import "GameScene.h"

@implementation NCTorchComponent

-(instancetype)init {
    self = [super init];
    if (self) {
        _priority = 0.0;
        _isLit = NO;
        _burnTime = 0.0;
        _burnOutTime = 60.0;
        _lightColor = [NSColor colorWithCalibratedRed:0.75 green:0.65 blue:0.25 alpha:1.0];
        _light = [SKLightNode new];
        _light.ambientColor = [NSColor blackColor];
        _light.lightColor = [NSColor blackColor];
        _light.falloff = 2.0;
        _light.categoryBitMask = 0x1;
    }
    return self;
}

-(void)updateWithDeltaTime:(NSTimeInterval)seconds {
    NCActorEntity *entity = (NCActorEntity *)self.entity;
    CGFloat daylight = entity.scene.daylight;
    
    _light.ambientColor = [entity.scene.ambientColor blendedColorWithFraction:daylight ofColor:[NSColor whiteColor]];
    
    if ([self isLit] && ![self isBurnedOut]) {
        CGFloat burnout = [self burnOut];
        entity.scene.torchlight = 1.0-burnout;
        _light.lightColor = [_lightColor blendedColorWithFraction:burnout>daylight?burnout:daylight
                                                          ofColor:[NSColor blackColor]];
        _burnTime += seconds;
    } else {
        entity.scene.torchlight = 0.0;
        _light.lightColor = [NSColor blackColor];
        _isLit = NO;
    }
}

-(BOOL)isBurnedOut {
    return _burnTime >= _burnOutTime;
}

-(CGFloat)burnOut {
    if ([self isBurnedOut])
        return 1.0;
    else
        return (_burnTime*_burnTime) / (_burnOutTime*_burnOutTime);
}

#pragma mark - NCPlayerInteraction Protocol

-(void)didLightTorch:(BOOL)isLit {
    _isLit = isLit;
}

-(void)didReplaceTorch {
    _burnTime = 0.0;
}

@end
