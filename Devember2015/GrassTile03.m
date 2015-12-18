//
//  GrassTile03.m
//  Devember2015
//
//  Created by Calle Englund on 18/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "GrassTile03.h"

@implementation GrassTile03

+(instancetype)tile {
    return (GrassTile03 *)[[IsoTile alloc] initWithImageNamed:@"Terrain/03-Grass" height:1.5 cost:1.0];
}

@end
