//
//  PlayerSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-05.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "PlayerSpriteNode.h"

@implementation PlayerSpriteNode

-(instancetype)init {
    self = [super init];
    if (self) {
        _myPosition = CGPointZero;
        _light = [[SKLightNode alloc] init];
        _light.ambientColor = [NSColor blueColor];
        _light.lightColor = [NSColor yellowColor];
        _light.falloff = 1.0;
        _light.categoryBitMask = 0x1;
        _lighttime = 0.0;
        [self addChild:_light];
        self.lightingBitMask = 0x1;
        
        [self reposition];
    }
    return self;
}

-(NSPoint)myPosition {
    return _myPosition;
}

-(void)setMyPosition:(NSPoint)myPosition {
    _myPosition = myPosition;
    [self reposition];
}

-(BOOL)reposition {
    [(IsoTileMap *)[self parent] positionSprite:self at:_myPosition];
    return YES;
}

-(BOOL)moveNorth {
    _myPosition.y -= 1;
    return [self reposition];
}

-(BOOL)moveSouth {
    _myPosition.y += 1;
    return [self reposition];
}

-(BOOL)moveWest {
    _myPosition.x -= 1;
    return [self reposition];
}

-(BOOL)moveEast {
    _myPosition.x += 1;
    return [self reposition];
}

@end
