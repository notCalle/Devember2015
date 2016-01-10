//
//  RockyMountainTile05.m
//  Devember2015
//
//  Created by Calle Englund on 18/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "RockyMountainTile05.h"

@implementation RockyMountainTile05

+(instancetype)tile {
    return (RockyMountainTile05 *)[[IsoTile alloc] initWithImageNamed:@"Terrain/05-Rocky mountains" height:0.9 cost:3.0];
}

@end
