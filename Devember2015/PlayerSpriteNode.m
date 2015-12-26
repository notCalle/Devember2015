//
//  PlayerSpriteNode.m
//  Devember2015
//
//  Created by Calle Englund on 2015-12-05.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "PlayerSpriteNode.h"
#import "MobSpriteNode.h"

@implementation PlayerSpriteNode

-(SKLightNode *)addLightNode {
    _lightTime = 0.0;
    return _light;
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];

}

@end
