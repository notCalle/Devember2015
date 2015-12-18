//
//  GrassyMountainTile04.m
//  Devember2015
//
//  Created by Calle Englund on 18/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "GrassyMountainTile04.h"

@implementation GrassyMountainTile04

+(instancetype)tile {
    return (GrassyMountainTile04 *)[[IsoTile alloc] initWithImageNamed:@"Terrain/04-Grassy mountains" height:2.0 cost:1.5];
}

@end
