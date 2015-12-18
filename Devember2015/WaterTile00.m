//
//  WaterTile00.m
//  Devember2015
//
//  Created by Calle Englund on 18/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "WaterTile00.h"

@implementation WaterTile00

+(instancetype)tile {
    return (WaterTile00 *)[[IsoTile alloc] initWithImageNamed:@"Terrain/00-Water" height:0 cost:5.0];
}

@end
