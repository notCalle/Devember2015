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
    return (GrassTile02 *)[[IsoTile alloc] initWithImageNamed:@"Terrain/1111-Ground" height:0.6 cost:1.0];
}

@end
