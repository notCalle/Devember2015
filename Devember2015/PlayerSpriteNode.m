//
//  PlayerSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-05.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "PlayerSpriteNode.h"

@implementation PlayerSpriteNode

-(SKLightNode *)addLightNode {
    if (!_light) {
        _light = [[SKLightNode alloc] init];
        [self addChild:_light];
    }
    _lightColor = [NSColor yellowColor];
    _ambientColor = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.25 alpha:1.0];
    _light.ambientColor = [NSColor whiteColor];
    _light.lightColor = [NSColor blackColor];
    _light.falloff = 1.0;
    _light.categoryBitMask = 0x1;
    _light.yScale = 0.5;
    _lightTime = 0.0;
    self.lightingBitMask = 0x1;
    return _light;
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    if (_lightTime == 0.0) {
        _lightTime = currentTime;
    }
    NSTimeInterval burnTime = (currentTime - _lightTime);
    if (burnTime < 60.0) {
        _light.lightColor = [_lightColor blendedColorWithFraction:(burnTime*burnTime)/3600.0 ofColor:[NSColor blackColor]];
    }
    _light.ambientColor = [_ambientColor blendedColorWithFraction:cos(currentTime/60.0) + cos(currentTime/3600.0)*0.5
                                                          ofColor:[NSColor whiteColor]];
}

@end
