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
    _ambientColor = [NSColor blueColor];
    _light.ambientColor = _ambientColor;
    _light.lightColor = _lightColor;
    _light.falloff = 1.0;
    _light.categoryBitMask = 0x1;
    _light.yScale = 0.5;
    _lightTime = 0.0;
    self.lightingBitMask = 0x1;
    return _light;
}

-(void)update:(NSTimeInterval)currentTime {
    if (_lightTime == 0.0) {
        _lightTime = currentTime;
    }
    NSTimeInterval burnTime = (currentTime - _lightTime);
    if (burnTime < 60.0) {
        _light.lightColor = [_lightColor blendedColorWithFraction:(burnTime*burnTime)/3600.0 ofColor:[NSColor blackColor]];
        _light.ambientColor = [_ambientColor blendedColorWithFraction:(burnTime*burnTime)/4000.0
                                                              ofColor:[NSColor blackColor]];
    }
}

@end
