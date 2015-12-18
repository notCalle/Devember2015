//
//  SandTile01.m
//  Devember2015
//
//  Created by Calle Englund on 18/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "SandTile01.h"

@implementation SandTile01

+(instancetype)tile {
    return (SandTile01 *)[[IsoTile alloc] initWithImageNamed:@"Terrain/01-Sandy" height:0.5 cost:1.5];
}

@end
