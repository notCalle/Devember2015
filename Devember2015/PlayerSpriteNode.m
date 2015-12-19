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
    _lightTime = 0.0;
    return _light;
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];

    if (!_light) {
        _light = [[SKLightNode alloc] init];
        [self addChild:_light];
        _lightColor = [NSColor colorWithCalibratedRed:0.75 green:0.65 blue:0.25 alpha:1.0];
        _ambientColor = [NSColor colorWithCalibratedRed:0.05 green:0.05 blue:0.1 alpha:1.0];
        _light.ambientColor = [NSColor blackColor];
        _light.lightColor = [NSColor blackColor];
        _light.falloff = 2.0;
        _light.categoryBitMask = 0x1;
        self.lightingBitMask = 0x0;
        _lightTime = 0.1;
    }

    CGFloat daylight = cos(currentTime/60.0)*0.75 + cos(currentTime/600.0)*0.25;
    if (daylight > 1.0)
        daylight = 1.0;
    else if (daylight < 0.0)
        daylight = 0.0;
    
    _light.ambientColor = [_ambientColor blendedColorWithFraction:daylight ofColor:[NSColor whiteColor]];

    if (_lightTime == 0.0) {
        _lightTime = currentTime;
    }
    NSTimeInterval burnTime = (currentTime - _lightTime);
    if (burnTime < 60.0) {
        CGFloat burnout = (burnTime*burnTime)/3600.0;
        _light.lightColor = [_lightColor blendedColorWithFraction:burnout>daylight?burnout:daylight
                                                          ofColor:[NSColor blackColor]];
    }
}

@end
