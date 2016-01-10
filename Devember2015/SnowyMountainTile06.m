//
//  SnowyMountainTile06.m
//  Devember2015
//
//  Created by Calle Englund on 18/12/15.
//  Copyright © 2015 Calle Englund. All rights reserved.
//

#import "SnowyMountainTile06.h"

@implementation SnowyMountainTile06

+(instancetype)tile {
    return (SnowyMountainTile06 *)[[IsoTile alloc] initWithImageNamed:@"Terrain/06-Snowy mountains" height:0.9 cost:4.0];
}

@end
