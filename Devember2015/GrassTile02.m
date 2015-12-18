//
//  GrassTile02.m
//  Devember2015
//
//  Created by Calle Englund on 18/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "GrassTile02.h"

@implementation GrassTile02

+(instancetype)tile {
    return (GrassTile02 *)[[IsoTile alloc] initWithImageNamed:@"Terrain/02-Grass" height:1.0 cost:1.0];
}

@end
