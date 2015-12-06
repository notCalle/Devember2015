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
    _lightTime = 0.0;
    self.lightingBitMask = 0x1;
    return _light;
}

-(void)reParent:(ITSpriteNode *)newParent {
    if (self.parent) {
        [self removeFromParent];
    }
    [newParent addChild:self];
}

-(BOOL)move:(char)direction {
    ITSpriteNode *currentPlace = (ITSpriteNode *)[self parent];
    ITSpriteNode *newPlace = nil;
    
    switch (direction) {
        case 'N':
            newPlace = currentPlace.north;
            break;
        case 'S':
            newPlace = currentPlace.south;
            break;
        case 'W':
            newPlace = currentPlace.west;
            break;
        case 'E':
            newPlace = currentPlace.east;
            break;
    }
    if (newPlace) {
        [self reParent:newPlace];
        return YES;
    }
    return NO;
}

-(void)update:(NSTimeInterval)currentTime {
    if (_lightTime == 0.0) {
        _lightTime = currentTime;
    }
    NSTimeInterval burnTime = (currentTime - _lightTime);
    if (burnTime < 10.0) {
        _light.lightColor = [_lightColor blendedColorWithFraction:(burnTime*burnTime)/100.0 ofColor:[NSColor blackColor]];
        _light.ambientColor = [_ambientColor blendedColorWithFraction:(burnTime*burnTime)/120.0
                                                              ofColor:[NSColor blackColor]];
    }
}

@end
